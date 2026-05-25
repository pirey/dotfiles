;;; early-init.el --- Early startup optimizations -*- lexical-binding: t; -*-

;; Don't let package.el initialize at startup; use-package handles it
(setq package-enable-at-startup nil)

;; Maximise GC threshold during init to avoid GC pauses
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Restore saner GC values once Emacs has started up
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 64 1024 1024)   ; 64 MB
                  gc-cons-percentage 0.1)))
