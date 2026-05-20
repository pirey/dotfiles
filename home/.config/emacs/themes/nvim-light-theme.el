;;; nvim-light-theme.el --- Custom theme matching nvim_light alacritty colors

(deftheme nvim-light
  "Theme matching nvim_light colorscheme from alacritty config.")

(let ((bg          "#e0e2ea")
      (fg          "#14161b")
      (bg-alt      "#cdd1dc")
      (bg-hl       "#d4d8e5")
      (bg-visual   "#c8d3f5")
      (bg-search   "#b8d4f0")
      (line-nr     "#a0a4b8")
      (comment     "#5c6370")
      (red         "#d16969")
      (green       "#00aa00")
      (yellow      "#b5a000")
      (blue        "#0451a5")
      (magenta     "#c586c0")
      (cyan        "#2b91af")
      (black       "#c0c4d0")
      (border      "#a0a4b8")
      (diff-add    "#c8e6c9")
      (diff-del    "#ffcdd2")
      (diff-chg    "#bbdefb"))

  (custom-theme-set-faces
   'nvim-light

   ;; Basic
   `(default ((t (:background ,bg :foreground ,fg))))
   `(cursor ((t (:background ,fg))))
   `(region ((t (:background ,bg-visual :foreground ,fg))))
   `(match ((t (:background ,bg-search :foreground ,fg))))
   `(highlight ((t (:background ,bg-hl))))
   `(hl-line ((t (:background ,bg-hl))))
   `(icomplete-selected-match ((t (:background ,bg-hl :foreground ,fg))))
   `(fringe ((t (:background ,bg))))
   `(line-number ((t (:foreground ,line-nr))))
   `(line-number-current-line ((t (:foreground ,fg :weight bold))))
   `(vertical-border ((t (:foreground ,border))))
   `(window-divider ((t (:foreground ,border))))
   `(show-paren-match ((t (:background ,bg-visual :foreground ,fg))))
   `(show-paren-mismatch ((t (:background ,bg-visual :foreground ,red))))

   ;; Syntax
   `(font-lock-builtin-face ((t (:foreground ,cyan))))
   `(font-lock-keyword-face ((t (:foreground ,blue))))
   `(font-lock-type-face ((t (:foreground ,cyan))))
   `(font-lock-function-name-face ((t (:foreground ,yellow))))
   `(font-lock-variable-name-face ((t (:foreground ,fg))))
   `(font-lock-constant-face ((t (:foreground ,magenta))))
   `(font-lock-string-face ((t (:foreground ,green))))
   `(font-lock-comment-face ((t (:foreground ,comment :slant italic))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,comment))))
   `(font-lock-doc-face ((t (:foreground ,comment))))
   `(font-lock-preprocessor-face ((t (:foreground ,blue))))
   `(font-lock-number-face ((t (:foreground ,magenta))))
   `(font-lock-negation-char-face ((t (:foreground ,red))))

   ;; Mode line
   `(mode-line ((t (:background ,black :foreground ,fg))))
   `(mode-line-inactive ((t (:background ,bg :foreground ,comment))))
   `(mode-line-highlight ((t (:background ,bg-hl))))
   `(mode-line-emphasis ((t (:foreground ,fg :weight bold))))
   `(mode-line-buffer-id ((t (:foreground ,yellow :weight bold))))

   `(header-line ((t (:background ,bg-alt :foreground ,fg))))

   ;; Minibuffer
   `(minibuffer-prompt ((t (:foreground ,blue))))

   ;; Search
   `(isearch ((t (:background ,bg-search :foreground ,fg))))
   `(isearch-fail ((t (:background ,bg-visual :foreground ,red))))
   `(lazy-highlight ((t (:background ,bg-search :foreground ,fg))))
   `(query-replace ((t (:inherit isearch))))

   ;; Built-in
   `(button ((t (:underline t :foreground ,blue))))
   `(link ((t (:underline t :foreground ,blue))))
   `(link-visited ((t (:underline t :foreground ,magenta))))
   `(shadow ((t (:foreground ,comment))))
   `(success ((t (:foreground ,green))))
   `(warning ((t (:foreground ,yellow))))
   `(error ((t (:foreground ,red))))
   `(escape-glyph ((t (:foreground ,cyan))))

   `(trailing-whitespace ((t (:background ,red))))
   `(paren-face ((t (:foreground ,comment))))

   ;; Whitespace
   `(whitespace-space ((t (:foreground ,line-nr))))
   `(whitespace-tab ((t (:foreground ,line-nr))))
   `(whitespace-newline ((t (:foreground ,line-nr))))
   `(whitespace-empty ((t (:background ,bg-hl))))
   `(whitespace-indentation ((t (:background ,bg-hl))))
   `(whitespace-trailing ((t (:background ,red))))
   `(whitespace-line ((t (:background ,bg-hl :foreground ,yellow))))

   ;; Corfu
   `(corfu-current ((t (:background ,bg-search :foreground ,fg))))
   `(corfu-bar ((t (:background ,line-nr))))
   `(corfu-border ((t (:background ,border))))
   `(corfu-default ((t (:background ,bg-alt :foreground ,fg))))

   ;; Dired
   `(dired-directory ((t (:foreground ,cyan :weight bold))))
   `(dired-flagged ((t (:foreground ,red))))
   `(dired-header ((t (:foreground ,blue))))
   `(dired-ignored ((t (:foreground ,comment))))
   `(dired-mark ((t (:foreground ,yellow))))
   `(dired-marked ((t (:foreground ,yellow))))
   `(dired-perm-write ((t (:foreground ,fg))))
   `(dired-symlink ((t (:foreground ,cyan))))
   `(dired-warning ((t (:foreground ,yellow))))

   ;; Magit
   `(magit-section-highlight ((t (:background ,bg-hl))))
   `(magit-section-heading ((t (:foreground ,blue :weight bold))))
   `(magit-branch-remote ((t (:foreground ,cyan))))
   `(magit-branch-local ((t (:foreground ,blue))))
   `(magit-branch-current ((t (:foreground ,blue :weight bold :box t))))
   `(magit-hash ((t (:foreground ,comment))))
   `(magit-tag ((t (:foreground ,yellow))))
   `(magit-log-author ((t (:foreground ,fg))))
   `(magit-log-date ((t (:foreground ,comment))))
   `(magit-log-graph ((t (:foreground ,line-nr))))
   `(magit-diff-added ((t (:background ,diff-add :foreground ,green))))
   `(magit-diff-removed ((t (:background ,diff-del :foreground ,red))))
   `(magit-diff-context ((t (:foreground ,comment))))
   `(magit-diff-hunk-heading ((t (:background ,diff-chg :foreground ,fg))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,bg-hl :foreground ,fg))))
   `(magit-diff-file-heading ((t (:foreground ,fg))))
   `(magit-diff-file-heading-highlight ((t (:background ,bg-hl :foreground ,fg))))
   `(magit-diffstat-added ((t (:foreground ,green))))
   `(magit-diffstat-removed ((t (:foreground ,red))))
   `(magit-blame-heading ((t (:background ,bg-alt :foreground ,comment))))
   `(magit-process-ok ((t (:foreground ,green))))
   `(magit-process-ng ((t (:foreground ,red))))

   ;; Diff
   `(diff-added ((t (:background ,diff-add :foreground ,green))))
   `(diff-removed ((t (:background ,diff-del :foreground ,red))))
   `(diff-context ((t (:foreground ,fg))))
   `(diff-changed ((t (:background ,diff-chg :foreground ,fg))))
   `(diff-file-header ((t (:foreground ,blue))))
   `(diff-hunk-header ((t (:foreground ,comment))))
   `(diff-refine-added ((t (:background ,diff-add :foreground ,fg))))
   `(diff-refine-removed ((t (:background ,diff-del :foreground ,fg))))

   ;; Org
   `(org-level-1 ((t (:foreground ,blue :weight bold))))
   `(org-level-2 ((t (:foreground ,cyan))))
   `(org-level-3 ((t (:foreground ,yellow))))
   `(org-level-4 ((t (:foreground ,magenta))))
   `(org-level-5 ((t (:foreground ,cyan))))
   `(org-level-6 ((t (:foreground ,green))))
   `(org-level-7 ((t (:foreground ,comment))))
   `(org-level-8 ((t (:foreground ,comment))))
   `(org-document-title ((t (:foreground ,blue :weight bold :height 1.4))))
   `(org-document-info ((t (:foreground ,comment))))
   `(org-document-info-keyword ((t (:foreground ,comment))))
   `(org-code ((t (:foreground ,green))))
   `(org-verbatim ((t (:foreground ,green))))
   `(org-block ((t (:background ,bg-alt))))
   `(org-block-begin-line ((t (:background ,bg-alt :foreground ,comment))))
   `(org-block-end-line ((t (:background ,bg-alt :foreground ,comment))))
   `(org-date ((t (:foreground ,magenta :underline t))))
   `(org-footnote ((t (:foreground ,magenta :underline t))))
   `(org-link ((t (:underline t :foreground ,blue))))
   `(org-special-keyword ((t (:foreground ,comment))))
   `(org-todo ((t (:foreground ,yellow :weight bold))))
   `(org-done ((t (:foreground ,green :weight bold))))
   `(org-priority ((t (:foreground ,yellow :weight bold))))
   `(org-headline-done ((t (:foreground ,comment))))
   `(org-table ((t (:foreground ,fg))))
   `(org-formula ((t (:foreground ,magenta))))
   `(org-tag ((t (:foreground ,comment :weight bold))))
   `(org-tag-group ((t (:foreground ,comment))))
   `(org-warning ((t (:foreground ,red))))
   `(org-checkbox ((t (:foreground ,comment))))
   `(org-checkbox-statistics-done ((t (:foreground ,green))))
   `(org-checkbox-statistics-todo ((t (:foreground ,yellow))))
   `(org-mode-line-clock ((t (:foreground ,fg))))

   ;; Flymake
   `(flymake-error ((t (:underline (:style wave :color ,red)))))
   `(flymake-warning ((t (:underline (:style wave :color ,yellow)))))
   `(flymake-note ((t (:underline (:style wave :color ,cyan)))))
   `(flymake-end-of-line-diagnostics-face ((t (:foreground ,comment))))

   ;; Eglot
   `(eglot-mode-line ((t (:foreground ,blue))))

   ;; Markdown
   `(markdown-header-face-1 ((t (:foreground ,blue :weight bold))))
   `(markdown-header-face-2 ((t (:foreground ,cyan))))
   `(markdown-header-face-3 ((t (:foreground ,yellow))))
   `(markdown-header-face-4 ((t (:foreground ,magenta))))
   `(markdown-header-face-5 ((t (:foreground ,cyan))))
   `(markdown-header-face-6 ((t (:foreground ,green))))
   `(markdown-code-face ((t (:background ,bg-alt))))
   `(markdown-inline-code-face ((t (:foreground ,green))))
   `(markdown-link-face ((t (:underline t :foreground ,blue))))
   `(markdown-url-face ((t (:foreground ,cyan))))
   `(markdown-list-face ((t (:foreground ,fg))))
   `(markdown-markup-face ((t (:foreground ,comment))))
   `(markdown-bold-face ((t (:weight bold))))
   `(markdown-italic-face ((t (:slant italic))))

   ;; Evil
   `(evil-ex-substitute-matches ((t (:background ,red :foreground ,bg))))
   `(evil-ex-substitute-replacement ((t (:foreground ,green :underline t))))
   `(evil-ex-lazy-highlight ((t (:background ,bg-search))))
   `(evil-search-highlight-persist-highlight ((t (:background ,bg-search))))

   ;; Vertico / Marginalia
   `(vertico-current ((t (:background ,bg-hl))))
   `(vertico-group-title ((t (:foreground ,comment))))
   `(vertico-group-separator ((t (:foreground ,comment :strike-through t))))
   `(marginalia-documentation ((t (:foreground ,comment))))
   `(marginalia-size ((t (:foreground ,comment))))
   `(marginalia-mode ((t (:foreground ,blue))))
   `(marginalia-file-name ((t (:foreground ,fg))))
   `(marginalia-number ((t (:foreground ,magenta))))
   `(marginalia-string ((t (:foreground ,green))))
   `(marginalia-key ((t (:foreground ,blue))))
   `(marginalia-value ((t (:foreground ,cyan))))
   `(marginalia-null ((t (:foreground ,comment))))
   `(marginalia-true ((t (:foreground ,cyan))))
   `(marginalia-false ((t (:foreground ,red))))
   `(marginalia-function ((t (:foreground ,yellow))))
   `(marginalia-list ((t (:foreground ,magenta))))
   `(marginalia-char ((t (:foreground ,green))))
   `(marginalia-type ((t (:foreground ,cyan))))

   ;; Eshell
   `(eshell-prompt ((t (:foreground ,blue))))
   `(eshell-ls-directory ((t (:foreground ,cyan :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,cyan))))
   `(eshell-ls-executable ((t (:foreground ,green))))
   `(eshell-ls-readonly ((t (:foreground ,red))))
   `(eshell-ls-unreadable ((t (:foreground ,comment))))
   `(eshell-ls-missing ((t (:foreground ,red))))
   `(eshell-ls-product ((t (:foreground ,comment))))
   `(eshell-ls-backup ((t (:foreground ,comment))))
   `(eshell-ls-clutter ((t (:foreground ,yellow))))

   ;; Messages
   `(message-header-name ((t (:foreground ,comment))))
   `(message-header-cc ((t (:foreground ,cyan))))
   `(message-header-other ((t (:foreground ,fg))))
   `(message-header-subject ((t (:foreground ,blue :weight bold))))
   `(message-header-to ((t (:foreground ,blue))))
   `(message-header-xheader ((t (:foreground ,comment))))
   `(message-mml ((t (:foreground ,comment))))
   `(message-separator ((t (:foreground ,line-nr :strike-through t))))

   ;; Tab bar
   `(tab-bar ((t (:background ,bg :foreground ,fg))))
   `(tab-bar-tab ((t (:background ,black :foreground ,fg :box t))))
   `(tab-bar-tab-inactive ((t (:background ,bg :foreground ,comment :box t))))
   `(tab-line ((t (:background ,bg :foreground ,fg))))
   `(tab-line-tab ((t (:background ,bg-alt :foreground ,fg :box t))))
   `(tab-line-tab-inactive ((t (:background ,bg :foreground ,comment :box t))))

   ;; Term
   `(term ((t (:background ,bg :foreground ,fg))))
   `(term-color-black ((t (:foreground "#14161b" :background "#14161b"))))
   `(term-color-red ((t (:foreground "#a31515" :background "#a31515"))))
   `(term-color-green ((t (:foreground "#008000" :background "#008000"))))
   `(term-color-yellow ((t (:foreground "#795e26" :background "#795e26"))))
   `(term-color-blue ((t (:foreground "#0000ff" :background "#0000ff"))))
   `(term-color-magenta ((t (:foreground "#af00db" :background "#af00db"))))
   `(term-color-cyan ((t (:foreground "#008080" :background "#008080"))))
   `(term-color-white ((t (:foreground "#a0a4b8" :background "#a0a4b8"))))

   ;; Vterm
   `(vterm-color-default ((t (:foreground ,fg :background ,bg))))
   `(vterm-color-black ((t (:foreground "#14161b" :background "#14161b"))))
   `(vterm-color-red ((t (:foreground "#a31515" :background "#a31515"))))
   `(vterm-color-green ((t (:foreground "#008000" :background "#008000"))))
   `(vterm-color-yellow ((t (:foreground "#795e26" :background "#795e26"))))
   `(vterm-color-blue ((t (:foreground "#0000ff" :background "#0000ff"))))
   `(vterm-color-magenta ((t (:foreground "#af00db" :background "#af00db"))))
   `(vterm-color-cyan ((t (:foreground "#008080" :background "#008080"))))
   `(vterm-color-white ((t (:foreground "#a0a4b8" :background "#a0a4b8"))))

   ;; Compilation
   `(compilation-info ((t (:foreground ,cyan))))
   `(compilation-warning ((t (:foreground ,yellow))))
   `(compilation-error ((t (:foreground ,red))))
   `(compilation-line-number ((t (:foreground ,comment))))
   `(compilation-column-number ((t (:foreground ,comment))))
   `(compilation-mode-line-exit ((t (:foreground ,green))))
   `(compilation-mode-line-fail ((t (:foreground ,red))))
   `(compilation-mode-line-run ((t (:foreground ,yellow))))

   ;; Custom / Widget
   `(widget-button ((t (:underline t :foreground ,blue))))
   `(widget-field ((t (:background ,bg-alt :foreground ,fg))))
   `(widget-single-line-field ((t (:background ,bg-alt :foreground ,fg))))

   ;; Flyspell
   `(flyspell-duplicate ((t (:underline (:style wave :color ,yellow)))))
   `(flyspell-incorrect ((t (:underline (:style wave :color ,red)))))

   ;; Info
   `(info-header-xref ((t (:underline t :foreground ,blue))))
   `(info-node ((t (:foreground ,blue))))
   `(info-menu-header ((t (:foreground ,blue :weight bold))))
   `(info-menu-star ((t (:foreground ,fg))))
   `(info-title-1 ((t (:foreground ,blue :weight bold :height 1.4))))
   `(info-title-2 ((t (:foreground ,blue :weight bold :height 1.2))))
   `(info-title-3 ((t (:foreground ,blue :weight bold :height 1.1))))
   `(info-title-4 ((t (:foreground ,blue :weight bold :height 1.0))))))

(custom-theme-set-variables
 'nvim-light
 '(ansi-color-names-vector ["#14161b" "#a31515" "#008000" "#795e26"
                            "#0000ff" "#af00db" "#008080" "#a0a4b8"])
 '(ansi-color-faces-vector [default bold shadow italic underline]))

(provide-theme 'nvim-light)

;;; nvim-light-theme.el ends here
