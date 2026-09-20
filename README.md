# Ubuntu workstation

Reproducible configuration for an Ubuntu development workstation. Chezmoi owns
user configuration, while Ansible installs system packages and development
tools.

## Layout

| Path | Purpose |
|---|---|
| `home/` | Chezmoi source state for files under `$HOME` |
| `ansible/` | Ubuntu workstation provisioning |
| `home/dot_config/nvim/` | Lua-only Neovim 0.12 configuration |
| `home/dot_config/opencode/core/` | Portable OpenCode harness |
| `home/dot_local/bin/` | Shared build and remote-editor commands |

Credentials, SSH host definitions, OAuth state, project keys, and generated
build state are deliberately not managed here.

## Daily use

Preview configuration changes before applying them:

```bash
cd /path/to/dotfiles
chezmoi --source "$PWD" diff
chezmoi --source "$PWD" apply
```

Provisioning and editor-specific workflows are documented alongside their
configuration.
