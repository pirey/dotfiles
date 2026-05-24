;;; init.el --- Minimal Emacs config
;; Requires Emacs 30+

;;; Theme
(add-to-list 'custom-theme-load-path
    (expand-file-name "themes" user-emacs-directory))
(load-theme 'nvim-dark t)

(fido-vertical-mode 1)
(editorconfig-mode 1)
(menu-bar-mode -1)
(setq-default truncate-lines t)
(setq inhibit-startup-screen t
    mouse-wheel-flip-direction t
    mouse-wheel-tilt-scroll t
    use-file-dialog nil
    confirm-kill-emacs nil
    ring-bell-function 'ignore
    scroll-error-top-bottom t
    auto-save-default nil
    make-backup-files nil)

;; GUI only
(when (display-graphic-p)
    (add-to-list 'default-frame-alist '(fullscreen . maximized))
    (add-to-list 'default-frame-alist '(font . "Ioskeley Mono-15"))
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (setq-default line-spacing 8))

;; TUI only
(unless (display-graphic-p)
    (xterm-mouse-mode 1)
    (setq interprogram-cut-function
        (lambda (text &optional _)
            (with-temp-buffer (insert text) (call-process-region (point-min) (point-max) "pbcopy"))))
    (setq interprogram-paste-function
        (lambda ()
            (with-temp-buffer (call-process "pbpaste" nil t) (buffer-string)))))

;;; Package management

(require 'package)
(push '("melpa" . "https://melpa.org/packages/") package-archives)
(require 'use-package)

;;; Editing

(use-package evil
    :ensure t
    :init
    (setq evil-want-integration t
        evil-undo-system 'undo-redo
        evil-want-C-u-scroll t
        evil-want-C-u-delete t
        evil-vsplit-window-right t)
    :config
    (evil-mode 1)
    (dolist (mode '(xref--xref-buffer-mode Buffer-menu-mode dired-mode flymake-diagnostics-buffer-mode diff-mode))
        (evil-set-initial-state mode 'emacs))
    (define-key evil-normal-state-map ";" 'evil-ex)
    (define-key evil-normal-state-map ":" 'evil-repeat-find-char)
    (define-key evil-visual-state-map ";" 'evil-ex)
    (define-key evil-visual-state-map ":" 'evil-repeat-find-char)
    (define-key evil-insert-state-map (kbd "C-h") 'delete-backward-char))

(use-package evil-surround
    :ensure t
    :init (global-evil-surround-mode 1))

(use-package company
    :ensure t
    :custom
    (company-idle-delay 0.2)
    (company-minimum-prefix-length 2)
    (company-tooltip-limit 10)
    :init (global-company-mode 1))

;;; LSP
(use-package eglot
    :defer t
    :custom
    (eglot-autoshutdown t)
    (eglot-send-changes-idle-time 0.5)
    :config
    (define-key eglot-mode-map (kbd "C-c C-a") 'eglot-code-actions)
    (define-key eglot-mode-map (kbd "C-c f") #'eglot-format-buffer)
    (define-key eglot-mode-map (kbd "C-c r") #'xref-find-references))

(setq eglot-server-programs
    '((php-mode . ("phpactor" "language-server"))
         (js-mode . ("vtsls" "--stdio"))
         (tsx-mode . ("vtsls" "--stdio"))
         (typescript-mode . ("vtsls" "--stdio"))
         (css-mode . ("css-languageserver" "--stdio"))))

(dolist (hook '(php-mode-hook js-mode-hook typescript-mode-hook tsx-mode-hook css-mode-hook lua-mode-hook))
    (add-hook hook 'eglot-ensure))

(setq flymake-fringe-indicator-position 'left-fringe
    flymake-show-diagnostics-at-end-of-line nil
    flymake-suppress-zero-counters t)

;;; Programming modes
(use-package php-mode :ensure t :mode "\\.php\\'")
(use-package typescript-mode :ensure t :mode "\\.ts\\'")

(define-derived-mode tsx-mode typescript-mode "TSX" "Major mode for TSX/JSX files.")
(put 'tsx-mode 'eglot-language-id "typescriptreact")
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . tsx-mode))

(use-package markdown-mode
    :ensure t
    :mode ("\\.md\\'" . markdown-mode)
    :init (setq markdown-command "pandoc"))

;;; Terminal
(use-package eat
    :ensure t
    :commands (eat)
    :config
    (eat-eshell-mode 1)
    (add-hook 'eat-mode-hook
        (lambda ()
            (evil-emacs-state)
            (setq-local show-trailing-whitespace nil))))

;;; Git
(use-package magit
    :ensure t
    :commands (magit-status)
    :config
    (setq magit-diff-refine-hunk 'all
        magit-log-arguments '("--no-graph" "-n256")))

(use-package diff-hl
    :ensure t
    :config
    (global-diff-hl-mode 1)
    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh t))

;;; Org
(use-package org
    :defer t
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
(global-set-key (kbd "C-c t") #'eat)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c g") #'magit-status)
(global-set-key (kbd "C-c i") #'imenu)
(global-set-key (kbd "C-c d") #'flymake-show-buffer-diagnostics)
(global-set-key (kbd "C-c D") #'flymake-show-project-diagnostics)
(global-set-key (kbd "C-c e") #'flymake-goto-next-error)
(global-set-key (kbd "C-c E") #'flymake-goto-prev-error)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
    (load custom-file))
