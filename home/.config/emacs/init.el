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

;; GUI only — applied to new frames (works with emacsclient daemon)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(font . "Ioskeley Mono-15"))

(defun my-gui-setup (&optional frame)
    (when (display-graphic-p frame)
        (with-selected-frame (or frame (selected-frame))
            (tool-bar-mode -1)
            (scroll-bar-mode -1))))
(my-gui-setup)
(add-hook 'after-make-frame-functions #'my-gui-setup)

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
(setq package-quickstart t)
(package-initialize)
(require 'use-package)

;;; Editing

(use-package evil
    :ensure t
    :init
    (setq evil-undo-system 'undo-redo
        evil-want-C-u-scroll t
        evil-want-C-u-delete t
        evil-vsplit-window-right t)
    :config
    (evil-mode 1)
    (define-key evil-normal-state-map ";" 'evil-ex)
    (define-key evil-normal-state-map ":" 'evil-repeat-find-char)
    (define-key evil-visual-state-map ";" 'evil-ex)
    (define-key evil-visual-state-map ":" 'evil-repeat-find-char)
    (define-key evil-insert-state-map (kbd "C-h") 'delete-backward-char))

(use-package evil-surround
    :ensure t
    :init (global-evil-surround-mode 1))

;;; LSP
(use-package eglot
    :defer t
    :custom
    (eglot-autoshutdown t)
    (eglot-send-changes-idle-time 0.5)
    :config
    (define-key eglot-mode-map (kbd "C-c C-a") 'eglot-code-actions)
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

;;; Formatting
(use-package apheleia
    :ensure t
    :config
    (setf (alist-get 'php-cs-fixer apheleia-formatters)
        '("sh" "-c"
             "tmp=$(mktemp); cat >\"$tmp\"; php-cs-fixer fix --quiet \"$tmp\"; cat \"$tmp\"; rm \"$tmp\""))
    (setf (alist-get 'php-mode apheleia-mode-alist) '(php-cs-fixer)))

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
(use-package vterm
    :ensure t
    :commands (vterm)
    :config
    (setq vterm-kill-buffer-on-exit t)
    (add-hook 'vterm-mode-hook
        (lambda ()
            (setq-local show-trailing-whitespace nil)
            (define-key vterm-mode-map (kbd "C-h") 'vterm--self-insert)
            (define-key vterm-mode-map (kbd "C-u") 'vterm--self-insert))))

;;; Git
(use-package magit
    :ensure t
    :commands (magit-status)
    :config
    (setq magit-diff-highlight-hunk-body nil))

;;; Keybindings
(global-set-key (kbd "C-c SPC") #'set-mark-command)
(global-set-key (kbd "C-c t") #'vterm)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c g") #'magit-status)
(global-set-key (kbd "C-c i") #'imenu)
(global-set-key (kbd "C-c f") #'apheleia-format-buffer)
(global-set-key (kbd "C-c d") #'flymake-show-buffer-diagnostics)
(global-set-key (kbd "C-c D") #'flymake-show-project-diagnostics)
(global-set-key (kbd "C-c e") #'flymake-goto-next-error)
(global-set-key (kbd "C-c E") #'flymake-goto-prev-error)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
    (load custom-file))
