# Org Lite for Zed

A local extension for reading and editing Org files: structural syntax highlighting,
heading outline, embedded source-code highlighting, and nested heading folding.

## Install

1. Have Rust installed through rustup, and `python3` available on Zed's PATH.
   The Python server uses only the standard library.
2. Disable any other Org language extension to avoid competing `.org` associations.
3. Run `zed: install dev extension` and select this directory:
   `home/.config/zed/extensions/org-lite` within the dotfiles repository.
   After Stow, it is also accessible at `~/.config/zed/extensions/org-lite`.
   Installing the dev extension compiles it; Zed downloads its grammar tooling.
4. Merge this into your Zed settings (the language name is `Org`):

   ```json
   {
     "languages": {
       "Org": {
         "document_folding_ranges": "on"
       }
     }
   }
   ```

The extension source directory alone does not activate the extension. Install it
with the dev-extension action even after Stow creates the symlink. No symlinks or
settings changes are performed by this repository addition.

## Use

Open `example.org`. The outline panel lists nested headings. Use Zed's fold gutter
or `editor: fold` / `editor: unfold` actions on a heading. Its fold extends through
the line before the next heading of equal or lesser depth. Drawers and paired
`#+begin_*` / `#+end_*` blocks also fold, including their closing line. Heading-like
text within blocks is ignored by the folding server.

Highlighting covers headings, common task states, tags, planning timestamps,
properties, directives, comments, list markers, and checkboxes. Source blocks use
the first parameter as the injected language; that language must be available in
Zed. Org language aliases such as `emacs-lisp` may need an extension or a matching
language name. Theme colors depend on the active Zed theme.

This first version does not implement inline Org emphasis/link parsing, agenda,
TODO cycling, table editing, export, or Emacs-style Tab visibility cycling. The
upstream grammar models inline prose as generic expressions. Highlight queries
cannot reliably supply the missing inline syntax; that needs grammar work.

The folding server keeps only open document text in memory and uses full-document
LSP synchronization. It does not read workspace files, access the network, or
install Python packages. The Rust adapter embeds and launches it with `python3`.

## Development

- `extension.toml`: pinned Tree-sitter grammar and language-server registration.
- `languages/org/`: file association, highlights, outline, and source injections.
- `src/lib.rs`: Zed adapter, using published `zed_extension_api` 0.7.0.
- `server/org_lsp.py`: stdio LSP framing and folding ranges.

Rebuild/reinstall the dev extension after changes, including Python changes, since
its source is embedded in the compiled adapter. Use `zed: open log` for failures.
Builds and runtime tests have not been run as part of adding this extension.

References:
- https://zed.dev/docs/extensions/developing-extensions
- https://zed.dev/docs/extensions/languages
- https://zed.dev/docs/reference/all-settings#lsp-folding-ranges
- https://github.com/milisims/tree-sitter-org
- https://github.com/hron/zed-org (existing Org extension used as a reference)
