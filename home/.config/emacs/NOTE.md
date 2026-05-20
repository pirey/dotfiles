## show info about current buffer mode:
M-x describe-mode RET
C-h m

## find and replace in project
C-x p g
C-x p r
press y/SPC to confirm replace, n to skip

## buffer management
M-x ibuffer
d to mark deletion
x to confirm delete buffers

## navigation cheat sheet

### cursor movement
C-f / C-b        forward / backward char
M-f / M-b        forward / backward word
C-n / C-p        next / previous line
C-a / C-e        beginning / end of line
M-a / M-e        beginning / end of sentence
M-{ / M-}        previous / next paragraph
M-< / M->        beginning / end of buffer
C-v / M-v        page down / page up
M-g M-g / M-g g  go to line (prompt for number)

### window / frame
C-x o            other window (cycle)
C-x 0            close current window
C-x 1            close other windows (keep one)
C-x 2            split window below
C-x 3            split window right
C-x w v          split & follow (like C-x 3 + C-x o)
C-x ^            enlarge window vertically
C-x }            enlarge window horizontally
C-x {            shrink window horizontally
C-x +            balance window sizes
C-x 5 2          new frame
C-x 5 0          close frame
C-x C-f          find file (minibuffer)

### tab bar (built-in, Emacs 27+)
C-x t 2          new tab
C-x t 0          close tab
C-x t o          next tab
C-x t [ / C-x t p  previous tab
C-x t ] / C-x t n  next tab (also 'o')
C-x t O / M-x tab-next

### search
C-s              isearch forward
C-r              isearch backward
M-s .            isearch word at point
C-s C-s          repeat isearch on current pattern
C-r C-r          repeat backward isearch on current pattern
RET              finish search (leave point)
C-g              cancel search
M-%              query-replace
C-M-%            query-replace-regexp
M-x rg           ripgrep (consult or built-in project-find-regexp)

### editing (undo/redo)
C-z              undo (linear, skips branches)
C-Z / C-x u      redo / undo-tree
C-SPC / C-@      set mark
C-w              kill region
M-w              copy region
C-y              yank (paste)
M-y              cycle yank history (after C-y)
C-k              kill line (from point to end)
M-q              fill paragraph
M-;             comment-dwim (toggle comment on region/line)
C-t              transpose chars
M-t              transpose words
TAB              indent (major-mode dependent)

### help (discover emacs)
C-h C-h          help overview
C-h k <key>      describe key binding
C-h v <var>      describe variable
C-h f <func>     describe function
C-h m            describe current mode
C-h b            list keybindings for current buffer
M-x help-with-tutorial-spec  interactive tutorial

## startup optimizations

### early-init.el
Emacs loads `early-init.el` **before** `init.el` — it's the very first file read at
startup. Use it for things that need to be set before `init.el` runs:

- `package-enable-at-startup` → set to `nil` so `use-package` controls loading
- `gc-cons-threshold` → crank up to `most-positive-fixnum` to avoid GC pauses
- `inhibit-startup-screen` → kill the splash before it renders
- `file-name-handler-alist` → temporarily nil out for faster file resolution

On macOS, `user-emacs-directory` is `~/.config/emacs/`, so early-init lives at:
`~/.config/emacs/early-init.el`

### package-quickstart
Bundles all installed packages' autoloads into **one** file
(`package-quickstart.el`) so Emacs doesn't scan every `elpa/` directory at
startup.

- **Without it**: reads 20+ individual `*-autoloads.el` files (one per package)
- **With it**: reads one merged file — ~2× faster package initialization

Enable it:
```elisp
(setq package-quickstart t)
(package-initialize)
```
After installing/updating packages, regenerate:
```
M-x package-quickstart-refresh RET
```

