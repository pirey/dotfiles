;;; init.el --- Minimal Emacs config
;; If a package fails to install, run M-x package-refresh-contents first
;; Requires Emacs 30+

;;; UI

(add-to-list 'custom-theme-load-path
             (expand-file-name "themes" user-emacs-directory))
(load-theme 'nvim-dark t)

;;;; Options

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(editorconfig-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(fido-vertical-mode 1)
(set-frame-font "Ioskeley Mono-15" nil t)
(setq-default line-spacing 8)
(setq-default truncate-lines t)
(setq mouse-wheel-flip-direction t)
(setq mouse-wheel-tilt-scroll t)
(setq use-file-dialog nil)
(setq confirm-kill-emacs nil)
(setq ring-bell-function 'ignore)
(setq scroll-error-top-bottom t)
(setq auto-save-default nil)

;;; Package management

(require 'package)
(push '("melpa" . "https://melpa.org/packages/") package-archives)

(package-initialize)

(require 'use-package)

;;; Completion

(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-preview-current t)
  :config
  (global-corfu-mode 1)
  (define-key corfu-map (kbd "C-n") 'corfu-next)
  (define-key corfu-map (kbd "C-p") 'corfu-previous))

;;; LSP

(use-package eglot
  :ensure nil
  :custom
  (eglot-autoshutdown t)
  (eglot-send-changes-idle-time 0.5))

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c C-a") 'eglot-code-actions))

(use-package mason
  :ensure t
  :config
  (mason-setup))

(setq eglot-server-programs
      '((php-mode . ("phpactor" "language-server"))
        (js-mode . ("vtsls" "--stdio"))
        (tsx-mode . ("vtsls" "--stdio"))
        (typescript-mode . ("vtsls" "--stdio"))
        (css-mode . ("css-languageserver" "--stdio"))))

(dolist (hook '(php-mode-hook js-mode-hook typescript-mode-hook tsx-mode-hook
                css-mode-hook lua-mode-hook))
  (add-hook hook 'eglot-ensure))

(setq flymake-fringe-indicator-position 'left-fringe
      flymake-show-diagnostics-at-end-of-line nil
      flymake-suppress-zero-counters t)

;;; Programming modes

(dolist (mapping
         '((js-mode . "\\.m?js\\'")
           (css-mode . "\\.css\\'")
           (c-mode . "\\.c\\'")))
  (add-to-list 'auto-mode-alist (cons (cdr mapping) (car mapping))))

(use-package php-mode
  :ensure t
  :mode "\\.php\\'")

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'")

;; Derived mode for .tsx/.jsx so eglot sends "typescriptreact" to vtsls
(define-derived-mode tsx-mode typescript-mode "TSX"
  "Major mode for TSX/JSX files.")
(put 'tsx-mode 'eglot-language-id "typescriptreact")
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . tsx-mode))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "pandoc"))

;;; Terminal

(use-package vterm
  :ensure t
  :commands vterm
  :config
  (setq vterm-kill-buffer-on-exit t))

(add-hook 'vterm-mode-hook
          (lambda ()
            (vterm-line-mode 1)
            (setq-local show-trailing-whitespace nil)))

;;; Git

(use-package magit
  :ensure t
  :commands (magit-status)
  :config
  (setq magit-diff-refine-hunk 'all
        magit-log-arguments '("--no-graph" "-n256")))

;;; Org

(use-package org
  :config
  (setq org-use-property-inheritance nil
        org-log-done nil
        org-adapt-indentation nil
        org-deadline-warning-days 3
        org-agenda-span 1
        org-todo-keywords '((sequence "TODO" "STARTED" "|" "DONE"))
        org-default-notes-file "~/org/tasks.org"
        org-agenda-files (append
                          (directory-files "~/org/" t "\\.org$")
                          (directory-files-recursively "~/vault-org/projects/" "\\.org$"))
        org-capture-templates
        '(("n" "Note" entry (file "~/org/inbox.org") "* %?\n  %u"))
        org-agenda-custom-commands
        '(("p" "Projects Agenda"
           ((agenda "")
            (tags-todo "+TODO=\"TODO\""))
           ((org-agenda-files
              (directory-files-recursively
               "~/vault-org/projects/" "\\.org$")))))))

;;; Keybindings

(global-set-key (kbd "C-c t") (lambda () (interactive) (vterm)))
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c g") #'magit-status)
(global-set-key (kbd "C-c f") #'eglot-format)
(global-set-key (kbd "C-c i") #'imenu)
(global-set-key (kbd "C-c d") #'flymake-show-buffer-diagnostics)
(global-set-key (kbd "C-c D") #'flymake-show-project-diagnostics)
(global-set-key (kbd "C-c e") #'flymake-goto-next-error)
(global-set-key (kbd "C-c E") #'flymake-goto-prev-error)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
