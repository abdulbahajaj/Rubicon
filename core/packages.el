;; Setting up Package manager
(defvar bootstrap-version)

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)

(straight-use-package 'use-package)

;; Installing and configuring packages 
(use-package no-littering
  :config
  (require 'no-littering))


(defmacro rubicon/github-package (package-name repo)
  `(use-package  ,package-name
     :straight (,package-name :type git :host github :repo ,repo)))

(use-package dash)

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config 
  (evil-mode 1)
  (evil-select-search-module 'evil-search-module 'evil-search))

(use-package counsel
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
	ivy-height 17
	ivy-wrap t
	ivy-magic-slash-non-match-action nil
	ivy-fixed-height-minibuffer t
	projectile-completion-system 'ivy
	ivy-use-virtual-buffers nil
	ivy-virtual-abbreviate 'full
	ivy-on-del-error-function #'ignore
	ivy-use-selectable-prompt t
	ivy-count-format "%d/%d")
  (setf (alist-get 't ivy-format-functions-alist)
	#'ivy-format-function-line))



(use-package general
  :config
  ;;(require 'general)
  (general-evil-setup))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :commands 'evilnc-comment-operator
  :config
  (evilnc-default-hotkeys nil t))

(use-package evil-embrace
  :config
  (evil-embrace-enable-evil-surround-integration))

(use-package magit)
(use-package evil-magit)


(use-package evil-vimish-fold
  :hook ((prog-mode . evil-vimish-fold-mode))
  :config
  (setq evil-vimish-fold-target-modes '(prog-mode conf-mode text-mode)))

(use-package evil-snipe
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode 1))

(use-package undo-tree)

(use-package smartparens
  :hook ((prog-mode . smartparens-mode)))

(use-package restart-emacs)

(use-package projectile
  :init
  (projectile-mode +1))

(use-package prescient
  :config
  (prescient-persist-mode))

(use-package ivy-prescient
  :after counsel
  :config
  (ivy-prescient-mode))

(use-package ob-async)

(use-package ivy-rich
  :after ivy
  :config
  (setq ivy-rich-parse-remote-buffer nil)
  (ivy-rich-mode 1)
  (setcdr
   (assq t ivy-format-functions-alist)
   #'ivy-format-function-line))

(use-package wgrep)

(use-package counsel-projectile)

(use-package avy)

(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config)

(use-package evil-indent-plus
  :config
  (evil-indent-plus-default-bindings))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
	hl-todo-keyword-faces
	`(;; For things that need to be done, just not today.
	  ("TODO" warning bold)
	  ;; For problems that will become bigger problems later if not
	  ;; fixed ASAP.
	  ("FIXME" error bold)
	  ;; For tidbits that are unconventional and not intended uses of the
	  ;; constituent parts, and may break in a future update.
	  ("HACK" font-lock-constant-face bold)
	  ;; For things that were done hastily and/or hasn't been thoroughly
	  ;; tested. It may not even be necessary!
	  ("REVIEW" font-lock-keyword-face bold)
	  ;; For especially important gotchas with a given implementation,
	  ;; directed at another user other than the author.
	  ("NOTE" success bold)
	  ;; For things that just gotta go and will soon be gone.
	  ("DEPRECATED" font-lock-doc-face bold))))

(use-package highlight-indent-guides
  :hook ((prog-mode text-mode conf-mode) . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'fill))

(use-package which-key
  :config
  (which-key-mode))

(use-package undo-fu
  :config
  (global-undo-tree-mode -1)
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "r" 'undo-fu-only-redo))

(use-package undo-fu-session
  :config
  (global-undo-fu-session-mode))

(use-package go-mode)
(use-package yaml-mode)

(use-package vterm
  :ensure t)

(use-package git-gutter-fringe
  :config
  :hook ((find-file . (lambda () (git-gutter-mode +1)))))

(use-package dired-rsync
  :hook (dired-mode . diredfl-mode)
  :config
  (bind-key "C-c C-r" 'dired-rsync dired-mode-map))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package diff-hl
  :hook ((dired-mode . diff-hl-dired-mode-unless-remote)
	 (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (diff-hl-margin-mode))

(use-package fd-dired
  :defer t
  :init
  (global-set-key [remap find-dired] #'fd-dired))

(use-package haskell-mode)

(use-package  highlight-thing
  :hook (prog-mode . highlight-thing-mode)
  :config
  (setq highlight-thing-delay-seconds 0.9))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package git-timemachine)


(use-package highlight-parentheses
  :hook (prog-mode . highlight-parentheses-mode))

(use-package forge
  :after magit)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package perspective
  :after ivy
  :config
  (setq persp-initial-frame-name "1")
  (persp-mode))

(use-package docker
  :ensure t)

(use-package treemacs
  :config
  (treemacs-resize-icons 16))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package esh-autosuggest
  :hook ((eshell-mode . esh-autosuggest-mode)))

(use-package eshell-up)

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-mode)
  (setq evil-goggles-duration 0.08))

(use-package clojure-mode)

(use-package sass-mode)

(use-package org-superstar
  :hook ((org-mode . (lambda () (org-superstar-mode 1)))))

(use-package evil-org
  :ensure t
  :after org
  :hook ((org-mode . evil-org-mode)
	 ('evil-org-mode . (lambda ()
			     (evil-org-set-key-theme))))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package ob-async)
(use-package dockerfile-mode)
(use-package  replel
  :straight
  (replel
   :type git
   :host github
   :repo "abdulbahajaj/repl.el"))

(use-package eshell-z)
(use-package eshell-prompt-extras)
(use-package esh-help)
(use-package eshell-git-prompt
  :config
  (eshell-git-prompt-use-theme 'powerline))

(use-package eshell-fringe-status
  :hook ((eshell-mode . eshell-fringe-status-mode)))

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview))

(use-package kubernetes-evil
  :ensure t
  :after kubernetes)

(setq lsp-keymap-prefix "s-l")
(use-package lsp-mode
  :hook ((python-mode . lsp)
	 (java-mode . lsp)
	 (c-mode . lsp)
	 (c++-mode . lsp)
	 (css-mode . lsp)
	 (html-mode . lsp)
	 (sh-mode . lsp)
	 (json-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package company-lsp
  :config
  (setq company-lsp-enable-snippet t
	company-lsp-cache-candidates t)
  (push 'company-lsp company-backends))

(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
(use-package dap-mode)

(use-package nyan-mode
  :config
  (setq nyan-animate-nyancat t)
  (setq nyan-wavy-trail t)
  (nyan-mode))

(use-package fish-completion
  :config
  (when (executable-find "fish") (global-fish-completion-mode)))


(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/org")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(use-package ns-auto-titlebar
  :config (ns-auto-titlebar-mode))

(use-package orgit)
(use-package org-tree-slide)
(use-package org-noter)
(use-package org-cliplink)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package doom-snippets
  :straight
  (doom-snippets
   :type git
   :host github
   :repo "hlissner/doom-snippets")
  :after yasnippet)

(use-package magit-popup
  :after magit)

(use-package magit-todos
  :after magit
  :config
  (add-hook 'magit-mode-hook 'magit-todos-mode))

(use-package better-jumper)

(use-package magit-gitflow)


(use-package dired-collapse
  :hook ((dired-mode . dired-collapse-mode)))

(use-package rainbow-identifiers)
(use-package rainbow-mode
  :hook ((prog-mode . rainbow-mode)))

(use-package bufler
  :straight
  (bufler :fetcher github :repo "alphapapa/bufler.el"
                  :files (:defaults (:exclude "helm-bufler.el"))))

(use-package helm-org-ql
  :straight
  (helm-org-ql
   :host github
   :repo "alphapapa/org-ql"
   :files ("helm-org-ql.el")))
(use-package calfw
  :config
  ;; (require 'calfw-org)
  :straight (calfw
	     :host github
	     :repo "kiwanami/emacs-calfw"))

(use-package helm-org-rifle)

(use-package org-sticky-header
  :config
  (setq org-sticky-header-full-path 'full
	org-sticky-header-heading-star ">>>>"
	org-sticky-header-outline-path-separator "/")

  (add-hook 'org-mode-hook 'org-sticky-header-mode))

(use-package org-timeline
  :config
  (require 'org-timeline)
  (add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append))

(use-package iedit)

(use-package dired-git-info
  ;; :hook ((dired-after-readin . dired-git-info-auto-enable))
  :config
  (setq dgi-auto-hide-details-p nil)
  (define-key dired-mode-map [backtab] 'dired-git-info-mode))

(use-package deft
  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/org"
		deft-extensions '("org" "md" "txt")
		deft-default-extension "org"
		deft-recursive t
		deft-use-filename-as-title nil
		deft-use-filter-string-for-filename t
		deft-file-naming-rules '((nospace . "-"))
		deft-extensions '("md" "org")))


