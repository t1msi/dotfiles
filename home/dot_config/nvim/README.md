# Neovim

This is a Lua-only Neovim 0.12 configuration. Plugins are installed by
`vim.pack` and pinned by `nvim-pack-lock.json`.

On first start, Neovim installs plugins and the configured Tree-sitter parsers.
Update plugins interactively, review the proposed revisions, and write the
confirmation buffer:

```vim
:lua vim.pack.update()
```

Tree-sitter parsers update automatically after the Tree-sitter plugin changes.
They can also be updated explicitly with `:TSUpdate`.

## Main mappings

| Mapping | Action |
|---|---|
| `<leader>ff` / `<leader>fg` | Find files / search text |
| `<A-e>` | Toggle file tree |
| `<leader>f` | Format buffer or selection |
| `<leader>ll` | Lint current buffer |
| `<leader>tr` / `<leader>tt` | Run a task / toggle task list |
| `<leader>tb` | Build the current qmake or CMake project |
| `<F3>` / `<S-F3>` | Next / previous search match |
| `<F4>` | Switch C/C++ source and header |
| `<F5>` / `<F10>` / `<F11>` / `<F12>` | Continue / step over / step into / step out |
| `<leader>db` | Toggle breakpoint |

The leader is comma. Use `<C-w>s` for a horizontal split, `<C-w>v` for a
vertical split, `<C-w>c` to close the current window, and `<C-w>o` to keep only
the current window. `<A-h/j/k/l>` moves between windows from normal, insert,
and terminal mode.

The C/C++ debugger uses `lldb-dap` or `lldb-vscode`; Python uses
`debugpy-adapter`. Tool installation belongs to the Ansible workstation role.
Qmake tasks call the editor-independent `qmake-workflow` command. Rust, Lua,
CMake, QML, and Pkl use their provisioned language servers; `.pro`, `.pri`, and
`.prf` files use the Make parser because qmake has no maintained Tree-sitter
grammar or language server.

The task picker includes configure, build, clean, clear, and rebuild operations
for qmake and CMake. `clean` preserves configuration; `clear` deletes the build
directory; `rebuild` clears, configures, and builds. Project-specific configure
arguments belong in `.qmake-workflow.args` or `.cmake-workflow.args`, one per
line.
