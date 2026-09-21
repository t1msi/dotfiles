# Ubuntu provisioning

Run the repository bootstrap from an Ubuntu x86_64 workstation:

```bash
./bootstrap
```

The bootstrap creates a pinned Ansible environment under
`~/.local/share/dotfiles/ansible`, provisions development dependencies,
previews the chezmoi changes, and applies them. The isolated environment avoids
Ubuntu's outdated Ansible package and user-site Python package conflicts.

The playbook is also usable directly after bootstrap:

```bash
~/.local/share/dotfiles/ansible/bin/ansible-galaxy collection install -r ansible/requirements.yml
~/.local/share/dotfiles/ansible/bin/ansible-playbook -i ansible/inventory/localhost.yml ansible/workstation.yml --check --diff
~/.local/share/dotfiles/ansible/bin/ansible-playbook -i ansible/inventory/localhost.yml ansible/workstation.yml
```

The qmake workflow defaults to
`/opt/qt-everywhere-src-5.15.2/qtbase/bin/qmake`. That project-specific Qt SDK
is not downloaded because its build options and licensing are external to this
repository. Override it with `-e qt_qmake_path=/path/to/qmake`.

Graphical workstations install Zed and Neovide from pinned upstream x86_64
release archives and register both editors with the desktop environment. Zed
requires a working Vulkan driver supplied by the host's AMD, Intel, or NVIDIA
graphics stack.

GUI provisioning is enabled by default. Disable it for a headless machine in
inventory or on the command line:

```yaml
workstation_gui_enabled: false
```

```bash
~/.local/share/dotfiles/ansible/bin/ansible-playbook \
  -i ansible/inventory/localhost.yml ansible/workstation.yml \
  -e workstation_gui_enabled=false
```

Headless hosts still receive Neovim, language servers, build tools, and the
remote editor helpers. Use Zed's native SSH Remote Development support or the
loopback-only Neovide helpers documented in `home/dot_local/bin/README.md`; the
remote host does not need a GPU.

For a remote host, first make sure its non-root development user has Python 3,
SSH access, and sudo. Then use the dedicated wrapper with the same inventory and
key options as any other Ansible playbook:

```bash
# Run once on the device console.
sudo apt-get update
sudo apt-get install --yes openssh-server python3
sudo systemctl enable --now ssh

# Run on the development workstation if the key is not installed yet.
chmod 600 "$HOME/.ssh/device"
ssh-copy-id -i "$HOME/.ssh/device.pub" developer@device-address
```

Add a machine-local `Host devbox` entry to `~/.ssh/config` and verify it with
`ssh devbox`. Then provision it:

```bash
remote-dev-workflow check \
  --key-file "$HOME/.ssh/device" \
  -i 'devbox,' \
  -u developer

remote-dev-workflow prepare \
  --key-file "$HOME/.ssh/device" \
  -i inventory-prod.yml \
  --limit devbox \
  -u developer
```

`check` adds Ansible check mode. `prepare` provisions the headless workstation,
copies only the tracked `home/` chezmoi source, previews its changes, and applies
it. Always use `--limit` when a shared production inventory contains hosts that
must not become development machines. The key, inventory, SSH aliases, and
passwords remain outside this repository.

Node.js and its bundled npm are also installed from a pinned upstream archive.
Do not add Ubuntu's separate `npm` package: it conflicts with NodeSource and
other self-contained Node.js packages.
