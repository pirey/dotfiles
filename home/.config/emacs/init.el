;;; init.el --- Minimal emacs config for orgmode

(require 'package)
(push '("melpa" . "https://melpa.org/packages/") package-archives)
(push '("org" . "https://orgmode.org/elpa/") package-archives)
(package-initialize)

; (unless (package-installed-p 'use-package)
;   (package-refresh-contents)
;   (package-install 'use-package))
(require 'use-package)

(use-package spacemacs-theme
  :ensure t)

(use-package org
  :ensure t
  :config
  (setq org-use-property-inheritance nil)
  (setq org-log-done nil)
  (setq org-adapt-indentation nil)
  (setq org-deadline-warning-days 3)
  (setq org-agenda-span 1)
  (setq org-todo-keywords '((sequence "TODO" "STARTED" "|" "DONE")))
  (setq org-default-notes-file "~/org/tasks.org")
  (setq org-agenda-files
      (append
       (directory-files-recursively "~/org/" "\\.org$")
       (directory-files-recursively "~/vault-org/" "\\.org$")))

  (setq org-capture-templates
    '(("n" "Note" entry (file+headline "~/org/dropnotes.org" "Notes")
         "* %?\n  %u" :empty-lines 1)))
  (setq org-agenda-custom-commands
        '(("p" "Projects Agenda"
           ((agenda "")
            (tags-todo "+TODO=\"TODO\""))
           ((org-agenda-files
             (directory-files-recursively
              "~/vault-org/projects" "\\.org$")))))))

(use-package magit
  :ensure t
  :commands (magit-status))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-u-delete t)
  :config
  (evil-mode 1))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "pandoc"))

(global-set-key (kbd "C-c a") #'org-agenda)

(global-set-key (kbd "C-c g") #'magit-status)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq-default
 indent-tabs-mode nil
 show-trailing-whitespace t)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode 1)

(setq use-file-dialog nil)
(setq confirm-kill-emacs nil)

; (set-frame-font "Ioskeley Mono" nil t)
(setq gc-cons-threshold (* 100 1000 1000))

(run-with-idle-timer 0 nil
  (lambda () (load-theme 'spacemacs-dark t)))

(set-frame-font "Ioskeley Mono-18" nil t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil magit markdown-mode spacemacs-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
