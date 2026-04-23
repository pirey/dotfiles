;;; init.el --- Minimal emacs config for orgmode

(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (expand-file-name "./"))

(setq use-package-always-ensure t)

(require 'package)
(push '("melpa" . "https://melpa.org/packages/") package-archives)
(push '("org" . "https://orgmode.org/elpa/") package-archives)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package catppuccin-theme
  :ensure t
  :config
  (load-theme 'catppuccin t))

(use-package org
  :ensure t
  :config
  (setq org-use-property-inheritance nil)
  (setq org-log-done nil)
  (setq org-adapt-indentation nil)
  (setq org-deadline-warning-days 3)
  (setq org-todo-keywords '((sequence "TODO" "STARTED" "|" "DONE")))
  (setq org-default-notes-file "~/org/tasks.org")
  (setq org-agenda-files '("~/org/" "~/vault-org/"))
  (setq org-capture-templates
    '(("n" "Note" entry (file+headline "~/org/dropnotes.org" "Notes")
         "* %?\n  %u" :empty-lines 1)))
  (setq org-agenda-custom-commands
        '(("p" "Projects Agenda"
            ((agenda)
             (tags-todo "+PROJECT"))))))

(use-package org-journal)

(use-package magit
  :ensure t
  :commands (magit-status))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil) ;; important if you later use evil-collection
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-u-delete t)
  :config
  (evil-mode 1))

;; optional but recommended
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(require 'org)
(setq org-agenda-span 1)
(global-set-key (kbd "C-c a") #'org-agenda)

(global-set-key (kbd "C-c g") #'magit-status)

(setq-default
 indent-tabs-mode nil
 show-trailing-whitespace t
 electric-pair-mode t)

(setq display-time-mode t)

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq use-file-dialog nil)
(setq confirm-kill-emacs nil)
(setq load-home 'no-confirm)

(setq-default major-mode 'text-mode)
(setq-default fill-column 80)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
(auto-save-mode -1)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(global-set-key (kbd "M-z") 'zap-to-char)
(global-set-key (kbd "M-Z") 'zap-up-to-char)

(set-face-attribute 'default nil :height 180)
(set-frame-font "Ioskeley Mono" nil t)
(global-hl-line-mode t)

(fset 'yes-or-no-p 'y-or-n-p)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(catppuccin-theme evil evil-collection magit org-journal)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
