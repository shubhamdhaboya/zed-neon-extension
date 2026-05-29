# NEON for Zed

[Zed](https://zed.dev) language support for **NEON** (Nette Object Notation) —
the configuration format used by the [Nette](https://nette.org) framework.
Files ending in `.neon`.

## Features

- **Syntax highlighting** — keys, strings, numbers, booleans, null,
  `@references`, `%parameters%`, entities, and comments
- **Bracket matching & autoclose** — `{}`, `[]`, `()`, quotes
- **Indentation** — tab-based, matching Nette conventions
- **Outline** — mapping keys appear in the symbol outline (`cmd-shift-o`)
- **Folding** — automatic, based on indentation

Powered by the [`tree-sitter-neon`](../tree-sitter-neon) grammar.

## Local development

1. Install Rust via [rustup](https://rustup.rs) — **required** by Zed for dev
   extensions (a Homebrew Rust will not work).
2. Open Zed → command palette → `zed: install dev extension` → select this
   directory.
3. Open any `.neon` file. Use `zed: open log` or run `zed --foreground` to
   debug.

The grammar is loaded locally via the `file://` URL in `extension.toml`. The
referenced `rev` must exist in the `tree-sitter-neon` git repository.

## Publishing

1. Push `tree-sitter-neon` to GitHub; switch the `[grammars.neon]` block in
   `extension.toml` to the remote `repository` + `rev` (see the commented
   block there).
2. Ensure a recognized `LICENSE` is present (MIT is included).
3. Fork [`zed-industries/extensions`](https://github.com/zed-industries/extensions),
   add this repo as a submodule under `extensions/`, add an entry to
   `extensions.toml`, run `pnpm sort-extensions`, and open a PR.

## License

MIT — see [LICENSE](LICENSE).
