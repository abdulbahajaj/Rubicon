;; -*- lexical-binding: t; -*-

(setq mac-command-modifier 'super
      mac-option-modifier  'meta)

(defconst rubicon/nvm-states
  '(normal visual motion))

(defmacro rubicon/define-leader (prefix)
  (let ((rb-definer-name (intern
			  (concat "rubicon/leader-" prefix))))
    `(general-create-definer
       ,rb-definer-name
       :prefix ,prefix
       :keymaps 'override
       :states rubicon/nvm-states)))

(rubicon/define-leader "SPC")
(rubicon/define-leader "<f13>")
(rubicon/define-leader "<f15>")

(general-nmap
 "TAB" 'evil-jump-item
  "u" 'undo-fu-only-undo
  "r" 'undo-fu-only-redo
  "g c" 'evilnc-comment-operator)

(general-define-key
 :states rubicon/nvm-states
 :keymaps 'override

 "#" 'swiper-isearch-thing-at-point

 "+" 'evil-window-increase-width
 "_" 'evil-window-decrease-width
 "M-=" 'evil-window-increase-height
 "M--" 'evil-window-decrease-height

 "L"  (ilm (right-char 10))
 "H"  (ilm (left-char 10))

 "/" 'swiper
 "?" 'swiper-all
 "*" 'evil-embrace-evil-surround-region
 "z g" 'evil-scroll-line-to-bottom
 "<DEL>" 'counsel-M-x
 [backspace] 'counsel-M-x

 "S-<SPC>"    'counsel-rg
 "s-<SPC>"    'counsel-locate

 ;; navigation
 "("          'evil-scroll-down
 ")"          'evil-scroll-up

 ;; split
 "<down>"     'evil-window-down
 "<left>"     'evil-window-left
 "<up>"       'evil-window-up
 "<right>"    'evil-window-right)

(rubicon/leader-SPC
  "<ESC>" 'delete-window
  "n" 'replel-start-repl
  "N" 'replel-overview

  "D" 'docker
  "d" 'rubicon/create-disposable-dir
  
  "y" 'rubicon/copy-path-to-buffer-file

  "0" (ilm (rubicon/workspace-switch "0"))
  "1" (ilm (rubicon/workspace-switch "1"))
  "2" (ilm (rubicon/workspace-switch "2"))
  "3" (ilm (rubicon/workspace-switch "3"))
  "4" (ilm (rubicon/workspace-switch "4"))
  "5" (ilm (rubicon/workspace-switch "5"))
  "6" (ilm (rubicon/workspace-switch "6"))
  "7" (ilm (rubicon/workspace-switch "7"))
  "8" (ilm (rubicon/workspace-switch "8"))
  "9" (ilm (rubicon/workspace-switch "9"))

  "TAB 0" (ilm (rubicon/workspace-switch "10"))
  "TAB 1" (ilm (rubicon/workspace-switch "11"))
  "TAB 2" (ilm (rubicon/workspace-switch "12"))
  "TAB 3" (ilm (rubicon/workspace-switch "13"))
  "TAB 4" (ilm (rubicon/workspace-switch "14"))
  "TAB 5" (ilm (rubicon/workspace-switch "15"))
  "TAB 6" (ilm (rubicon/workspace-switch "16"))
  "TAB 7" (ilm (rubicon/workspace-switch "17"))
  "TAB 8" (ilm (rubicon/workspace-switch "18"))
  "TAB 9" (ilm (rubicon/workspace-switch "19"))
  "TAB r" 'rename-buffer

  ;; Workspaces
  "TAB d" 'rubicon/workspace-delete
  "TAB TAB" 'rubicon/workspace-show-all
  "TAB s" 'persp-switch 

  "o" 'rubicon/workspace-kill-invisible-buffers
  "O" 'rubicon/workspace-kill-other-buffers

  "s" 'save-buffer
  "t" 'rubicon/eshell-here
  "T" 'vterm
  "r" 'counsel-recentf
  "R" 'ielm
  "e" 'eval-last-sexp
  "E" 'eval-buffer
  "'" 'ivy-resume

  "b" #'evil-buffer-new

  "SPC" '+ivy/projectile-find-file

  ;; Find functions, variables, etc
  "h w" 'what-cursor-position
  "h o" 'find-function-on-key
  "h f" 'find-function
  "h v" 'find-variable
  "h r" 'describe-variable
  "h k" 'describe-key
  "h m" 'describe-mode
  "h e" 'describe-face
  "h n" 'describe-font
  "h c" 'describe-char
  "h t" 'describe-theme
  "h a" 'describe-keymap
  "h s" 'describe-symbol
  "h b" 'describe-binding
  "h F" 'describe-fontset

  ;; Roam
  "a r" 'org-roam-dailies-today
  "a a" 'org-agenda-list
  "a t" 'org-todo-list
  "a c" 'cfw:open-org-calendar

  "c" 'org-capture

  "." 'counsel-find-file
  
  "," 'persp-counsel-switch-buffer
  
  "g" 'magit-file-dispatch
  "G" 'magit-dispatch

  "l" 'magit-log-current

  "k k" #'rubicon/workspace-kill-current-buffer
  "k u" 'smerge-keep-upper
  "k l" 'smerge-keep-lower
  "k a" 'smerge-keep-all
  "k n" 'smerge-next
  "k p" 'smerge-prev
  "k m" 'smerge-keep-mine

  ;; avy
  "f" 'avy-goto-char-timer
  "F" 'avy-goto-char
  "q r" 'avy-resume
  "m" 'avy-move-line
  "M" 'avy-move-region

  "P" 'proced

  ;; project
  "p s" #'counsel-projectile-switch-project
  "p d" #'projectile-add-known-project
  "p t" #'treemacs-add-project-to-workspace


  "z"  (ilm (evil-edit "."))
  "Z" 'treemacs-select-window
  "<right>" (ilm (rubicon/split-window "right"))
  "<up>" (ilm (rubicon/split-window "up"))
  "<left>" (ilm (rubicon/split-window "left"))
  "<down>" (ilm (rubicon/split-window "down")))

(rubicon/leader-<f13>
  "<right>" #'+evil/window-move-right
  "<up>" #'+evil/window-move-up
  "<left>" #'+evil/window-move-left
  "<down>" #'+evil/window-move-down)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; dirs/files navigation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro create-folder-nmap (shortcut file-name)
  `(progn
     (defalias (intern (concat "open-" (symbol-name (quote ,file-name))))
       (lambda ()
	 (interactive)
	 (e
	  (symbol-name
	   (quote ,file-name)))))
     (general-nmap ,shortcut
       (intern
	(concat "open-"
		(symbol-name (quote ,file-name)))))))


(create-folder-nmap "<f15> H" ~/                 )
(create-folder-nmap "<f15> P" ~/projects/        )
(create-folder-nmap "<f15> S" ~/scrap/           )
(create-folder-nmap "<f15> R" ~/repos/           )
(create-folder-nmap "<f15> E" ~/.emacs.d         )
(create-folder-nmap "<f15> D" ~/.doom.d          )
(create-folder-nmap "<f15> O" ~/org              )

(rubicon/leader-<f15>
  "e k" (ilm (e "~/.emacs.d/core/keybindings.el"))
  "e c" (ilm (e "~/.emacs.d/core/core.el"))
  "e p" (ilm (e "~/.emacs.d/core/packages.el"))
  "e i" (ilm (e "~/.emacs.d/init.el"))
  "o" (ilm (e "~/org/org.org"))
  "u" (ilm (e "~/org/schedule.org"))
  "d" (ilm (e "~/org/day.org"))
  "l" (ilm (e "~/org/timeline.org"))
  "i" (ilm (e "~/org/triage.org"))
  "t" (ilm (e "~/org/todo.org"))
  "g" (ilm (e "~/org/gist.org"))
  "n" (ilm (e "~/org/notes.org"))
  "s" (ilm (e "~/org/scrap.org"))
  "r" (ilm (e "~/.zshrc"))
  "p" (ilm (e "~/org/production.org"))
  "a" (ilm (e "~/org/agenda.org"))
  "b" (ilm (e "~/org/notebooks.org"))
  "C" (ilm (e "~/.emacs.d/core"))
  "c" (ilm (e "~/.emacs.d/init.el")))

(global-set-key [remap keyboard-quit] #'rubicon/escape)
(global-set-key [remap evil-force-normal-state] #'rubicon/escape)
(global-set-key [escape] #'rubicon/escape)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Eshell 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-define-key
 :keymaps 'eshell-mode-map
 :states 'insert
 "<f1>" (ilm (eshell/clear-scrollback)
	     (eshell-send-input))
 "<f13>" #'evil-collection-eshell-interrupt-process)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Vterm 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-define-key
 :states '(normal)
 :keymaps 'vterm-copy-mode-map
 "a" 'my-vterm-append
 "i" 'my-vterm-insert)

(general-define-key
 :states '(normal insert)
 :keymaps 'vterm-mode-map
 "<f1>" 'my-vterm-clear
 "<f15> e" (ilm (vt-insert-command "echo "))
 "<f15> x" 'vt-add-chmod
 "<f15> C" 'vterm-copy-mode-map
 "<f15> s" 'vt-add-sudo
 "<f15> H" (ilm (vt-cd-to "~") (vt-ls))
 "<f15> P" (ilm (vt-cd-to "~/projects") (vt-ls))
 "<f15> e" (ilm (vt-insert-command "echo "))
 "<f15> R" (ilm (vt-cd-to "~/repos") (vt-ls))
 "<f15> O" (ilm (vt-cd-to "~/org") (vt-ls))
 "<f15> B" (ilm (vt-cd-to "~/notebooks") (vt-ls))
 "<f15> S" (ilm (vt-cd-to "~/scrap") (vt-ls)))

(general-define-key
 :states 'normal
 :keymaps 'vterm-mode-map

 "{" (ilm (vt-pusdh "..") (vt-exec "ls"))
 "}" (ilm (vt-popd) (vt-exec "ls"))
 "[" (ilm (vt-pusdh "..") (vt-ls))
 "]" (ilm (vt-popd) (vt-ls))
 "o" (ilm (vt-ls))
 "O" (ilm (vt-exec "ls"))
 "c" (ilm (vt-insert-command "cd "))
 "C" (ilm (vt-insert-command "cat "))

 "x" (ilm (vt-insert-command "rm -rf "))
 "X" (ilm (vt-insert-command "sudo rm -rf "))

 "d" (ilm (vt-insert-command "mkdir "))
 "D" (ilm (vt-insert-command "touch "))

 "<f13> <f13>" 'vterm-send-C-c

 ;; "r" (ilm)
 "R" 'vt-source-zshrc)


(general-define-key
 :states 'normal
 :keymaps 'org-mode-map
 "<return>" '+org/dwim-at-point)



(general-define-key
 :states 'insert
 :keymaps 'vterm-mode-map

 "`" (ilm (vt-exec "fzf-history-widget"))
 "TAB" 'vterm-send-tab
 "S-<return>" 'vterm-run-and-go-up
 "M-<f13>" 'vt-rc
 "<f13>" 'vterm-send-C-c
 "<f14>" 'vterm-send-escape)

(general-define-key
 :keymaps 'dired-mode-map
 "[" 'dired-create-directory)

(general-define-key
 :keymaps 'org-mode-map
 :prefix "<f14>"
 "f" #'org-roam-insert
 "a" #'org-archive-subtree-default
 "t" #'counsel-org-tag
 "r" #'org-refile
 "i" #'org-date-from-calendar
 "l" #'org-cliplink
 "L" #'org-toggle-link-display
 "d" #'org-deadline
 "s" #'org-schedule
 "c" #'org-goto-calendar
 "C" #'count-words
 "h" #'org-insert-heading-respect-content)

(global-set-key [remap goto-line] 'goto-line-preview)


(global-set-key [remap execute-extended-command]
		'counsel-M-x)
(global-set-key [remap kill-current-buffer]
		'rubicon/workspace-kill-current-buffer)
(global-set-key [remap quit-window]
		'rubicon/workspace-quit-window)
(general-define-key
 ;; :states 'normal
 :keymaps 'replel-mode-map
 "<f1>" 'replel-run)
