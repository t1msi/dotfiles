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

Node.js and its bundled npm are also installed from a pinned upstream archive.
Do not add Ubuntu's separate `npm` package: it conflicts with NodeSource and
other self-contained Node.js packages.
