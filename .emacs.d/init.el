;; don't show the splash screen
(setq inhibit-startup-message t)

;; don't display the tool/scroll bars
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; auto-balance parens
(electric-pair-mode 1)

;; load theme and line numbers
(load-theme 'gruvbox-light-hard t)
(set-frame-font "Inconsolata 14" nil t)
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
  :init
    (setq evil-want-C-u-scroll t)
    (setq evil-undo-system 'undo-redo)
    (setq evil-want-keybinding nil)
  :config
    (when (require 'evil-collection nil t)
    (evil-collection-init))
    (evil-mode 1))

;; evil-surround setup
(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

;; helm basic config
(use-package helm-config
  :config
    (helm-mode 1))

;; projectile setup
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-project-search-path '(("Users/connor/Documents/" . 2)
				       ("/Users/connor/Projects/" . 4)))
(helm-projectile-on)

;; python setup
(setenv "WORKON_HOME" "/Users/connor/miniconda3/envs")  ;; proper environments
(elpy-enable)
(setq elpy-rpc-virtualenv-path 'current)

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
(setq latex-base-directory "/Users/connor/Documents/LaTeX/")

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

;; aesthetic changes
(setq default-frame-alist '((width . 120) (height . 55)))

(defun smallframe ()
    (interactive)
    (set-frame-size (selected-frame) 120 55)
    (set-frame-position (selected-frame) 890 55)
    ;; (set-frame-position (selected-frame) 900 50)
)

(defun bigframe ()
    (interactive)
    (set-frame-position (selected-frame) 200 55)
    (set-frame-size (selected-frame) 200 55)
    ;; (set-frame-position (selected-frame) 200 50)
)

(defun smallframe-laptop ()
    (interactive)
    (set-frame-size (selected-frame) 120 55)
    (set-frame-position (selected-frame) 675 50)
)

(defun bigframe-laptop ()
    (interactive)
    (set-frame-size (selected-frame) 195 55)
    (set-frame-position (selected-frame) 75 50)
)

(global-set-key (kbd "C-{") 'smallframe)
(global-set-key (kbd "C-}") 'bigframe)

(global-set-key (kbd "C-M-{") 'smallframe-laptop)
(global-set-key (kbd "C-M-}") 'bigframe-laptop)

;; setup to run external terminal from here
(defun iterm-here ()
    (interactive)
    (save-window-excursion (async-shell-command "open . -a terminal")))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" default))
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(jupyter auctex use-package elpy evil-collection magit helm gruvbox-theme projectile evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

