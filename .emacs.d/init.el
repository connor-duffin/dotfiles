;; backups: who needs em
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

;; don't display the tool/scroll bars
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; but do display relative linenums
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; auto-balance parens
(electric-pair-mode 1)

;; fill columns
(setq-default fill-column 80)
(global-display-fill-column-indicator-mode)
(set-frame-font "DejaVu Sans Mono 9" nil t)

;; melpa setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; checking for use-package
(eval-when-compile
  (require 'use-package))

(use-package visual-fill-column
  :ensure t
  :init
  (add-hook 'visual-line-mode-hook #'visual-fill-column-mode))

;; load theme and line numbers
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (require 'color-theme-sanityinc-tomorrow))

;; evil mode stuff
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; projectile setup
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-project-search-path '(("home/connor/Documents/" . 2)
					 ("/home/connor/Projects/" . 4))))

;; and helm
(use-package helm
  :ensure t
  :init
  (helm-projectile-on))

;; highlight TODOs in code
(use-package hl-todo
  :ensure t
  
  :custom-face
  (hl-todo ((t (:inherit hl-todo :italic t))))
  :hook ((prog-mode . hl-todo-mode)
         (yaml-mode . hl-todo-mode)))

;; setup flycheck
;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))

;; python setup
(setenv "WORKON_HOME" "/home/connor/miniconda3/envs")  ;; proper environments
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; org mode enabled and set up
(use-package org
  :config
  ;; org-babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t))))

;; better org-mode setup
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "/usr/bin/pandoc")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))

(use-package ess
  :ensure t
  :init (load "ess-autoloads"))

;; LaTeX setup (with AUCTeX)
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;; set the base directory
(setq latex-base-directory "/home/connor/Documents/LaTeX/")

;; auto-insert from template
(auto-insert-mode)
(setq auto-insert-directory latex-base-directory)
(setq auto-insert-query nil)
(define-auto-insert "\.tex" "template.tex")
(define-auto-insert "\.Rmd" "template.Rmd")

;; pull in updates to macros and bibliography'
(defun update-tex ()
    (interactive)
    (copy-file (concat latex-base-directory "macros.tex")
		(concat (magit-toplevel) "macros.tex") t)

    (copy-file (concat latex-base-directory "master.bib")
		(concat (magit-toplevel) "bibliography.bib") t)
    )

;; setup to run external terminal from here
(defun iterm-here ()
    (interactive)
    (save-window-excursion (async-shell-command "alacritty &")))

(global-set-key (kbd "C-\"") 'iterm-here)

;; setup sync to remote
(defun sync-remote ()
  "Travel up the path until .sync.sh is found, upon which, run .sync."
  (interactive)
  (save-buffer)
  (with-temp-buffer
	(while (and (not (file-exists-p ".sync.sh"))
		      (not (equal "/" default-directory)))
	(cd ".."))
	(when (file-exists-p ".sync.sh")
	    (save-window-excursion (async-shell-command "./.sync.sh")))))

;; sync to remote
(global-set-key (kbd "C-$") 'sync-remote)

;; evil-esque window moves
(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-h") 'windmove-left)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-j") 'windmove-down)

;; emacs window movement
;; (when (fboundp 'windmove-default-keybindings)
;;   (windmove-default-keybindings))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

;; startup time
(defun efs/display-startup-time ()
  (message
   "Emacs loaded in %s with %d garbage collections."
   (format
    "%.2f seconds"
    (float-time
     (time-subtract after-init-time before-init-time)))
   gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-tomorrow-day))
 '(custom-safe-themes
   '("bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" default))
 '(elpy-modules
   '(elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-folding elpy-module-pyvenv elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults))
 '(helm-minibuffer-history-key "M-p")
 '(org-agenda-files
   '("~/Documents/Org/daily.org" "/home/connor/Documents/Org/research.org"))
 '(package-selected-packages
   '(treemacs markdown-preview-mode hl-todo markdown-mode helm-projectile elpygen color-theme color-theme-sanityinc-tomorrow visual-fill-column flycheck origami jupyter auctex use-package elpy evil-collection magit helm gruvbox-theme projectile evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

