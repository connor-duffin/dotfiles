;; don't show the splash screen
(setq inhibit-startup-message t)

;; don't display the tool/scroll bars
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; auto-balance parens
(electric-pair-mode 1)

;; fill columns
(setq-default fill-column 120)
(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
(global-display-fill-column-indicator-mode)

;; load theme and line numbers
(require 'color-theme-sanityinc-tomorrow)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; melpa setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; checking for use-package
(eval-when-compile
  (require 'use-package))

;; evil mode setup
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

;; evil-surround setup
(use-package evil-surround
  :config
  (global-evil-surround-mode 1)
  :ensure t)

;; projectile setup
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-project-search-path '(("home/connor/Documents/" . 2)
				       ("/home/connor/Projects/" . 4)))
(helm-projectile-on)

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
    (save-window-excursion (async-shell-command "kitty")))

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
   '(helm-projectile elpygen color-theme color-theme-sanityinc-tomorrow visual-fill-column flycheck origami jupyter auctex use-package elpy evil-collection magit helm gruvbox-theme projectile evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

