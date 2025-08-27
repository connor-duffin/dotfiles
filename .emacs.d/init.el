;; Minimal Emacs init.el inspired by my old .spacemacs

;; Setup package sources
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

;; Basic UI tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-display-fill-column-indicator-mode)
(setq-default fill-column 80)
(setq c-basic-offset 4)
(setq org-src-preserve-indentation t)
(setq org-edit-src-content-indentation 0)
(setq org-src-window-setup 'current-window)
(setq org-latex-create-formula-image-program 'imagemagick)
(setq org-agenda-files '("~/Documents/Org/work.org"
                         "~/Documents/Org/life.org"))
(setq org-todo-keywords '((sequence "TODO" "PROG" "|" "DONE")))

;; Font (adjust as needed)
(set-frame-font "Menlo-12" nil t)

;; Environment variables
(setenv "WORKON_HOME" "~/miniconda3/envs")
(setq latex-base-directory "~/.LaTeX/")

;; Language modes
(use-package python
  :ensure t
  :config
  (setq python-indent-offset 4))

(use-package ess :ensure t)          ;; R, etc.
(use-package markdown-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package json-mode :ensure t)
(use-package csv-mode :ensure t)
(use-package vimrc-mode :ensure t)
(use-package cmake-mode :ensure t)
(use-package conda
  :ensure t
  :config (setq conda-anaconda-home "~/miniconda3"))

;; Org-mode (already built-in, but tweaks above)

;; LaTeX
(use-package auctex :ensure t)

;; Auto-insert templates
(use-package autoinsert
  :ensure nil
  :config
  (auto-insert-mode)
  (setq auto-insert-directory latex-base-directory)
  (setq auto-insert-query nil)
  (define-auto-insert "\\.tex\\'" "template.tex")
  (define-auto-insert "\\.Rmd\\'" "template.Rmd"))

;; Update TeX macros and bibliography
(defun update-tex ()
  (interactive)
  (copy-file (concat latex-base-directory "macros.tex")
             (concat (locate-dominating-file default-directory ".git") "macros.tex") t)
  (copy-file (concat latex-base-directory "master.bib")
             (concat (locate-dominating-file default-directory ".git") "bibliography.bib") t))

;; Remote sync function
(defun sync-remote ()
  "Travel up the path until .sync is found, then run .sync."
  (interactive)
  (save-buffer)
  (let ((dir default-directory))
    (while (and (not (file-exists-p (expand-file-name ".sync" dir)))
                (not (equal "/" (directory-file-name dir))))
      (setq dir (expand-file-name ".." dir)))
    (when (file-exists-p (expand-file-name ".sync" dir))
      (save-window-excursion (async-shell-command (concat dir "/.sync"))))))

(global-set-key (kbd "C-$") 'sync-remote)

;; Python Flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-python-flake8-executable "flake8")
  (setq flycheck-python-pylint-executable "python3"))

;; Polymode for Rmd, etc.
(use-package polymode :ensure t)
(use-package poly-R :ensure t)
(use-package poly-noweb :ensure t)
(use-package poly-markdown :ensure t)

;; Projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode 1)
  :config
  (setq projectile-completion-system 'ivy)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; ivy
(use-package ivy :ensure t)

;; Git integration
(use-package magit :ensure t)

;; Completion
(use-package company
  :ensure t
  :init (global-company-mode))

;; Evil (vim emulation with full evil-collection)
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))


;; Copilot (if installed, minimal setup)
;; (use-package copilot
;;   :ensure t
;;   :config
;;   (setq copilot-idle-delay nil))

;; Misc
(setq-default show-trailing-whitespace t)

;; End of file
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
