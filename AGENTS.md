# Dotfiles

Reproducible Ubuntu workstation configuration managed with chezmoi and Ansible.

## Change discipline

- Stage only intended files. Never use `git add -A`.
- Do not commit credentials, OAuth state, SSH keys, generated package state,
  build directories, `.opencode/harvest/`, or raw session exports.
- When implementing, use `small-commits` and `explanatory-commits`. This
  repository explicitly permits a commit after each verified logical step.
- Do not push unless the user asks.

## Configuration layers

- `home/` is the chezmoi source tree and maps to the user's home directory.
- `ansible/` provisions Ubuntu packages and developer tooling.
- `home/dot_config/opencode/core/` is the canonical portable OpenCode harness.
- Project decisions live in `.opencode/adr/`; compactons are evidence only.
- Machine credentials and host-specific SSH details stay outside Git.

## Verification

- Run focused checks after each change and the full repository checks before
  finishing.
- Use `chezmoi diff` before applying configuration to the real home directory.
- Use Ansible check mode before a provisioning run whenever practical.
