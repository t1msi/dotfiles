# Ubuntu provisioning

Run the repository bootstrap from an Ubuntu x86_64 workstation:

```bash
./bootstrap
```

The bootstrap installs Ansible, provisions development dependencies, previews
the chezmoi changes, and applies them. The playbook is also usable directly:

```bash
ansible-galaxy collection install -r ansible/requirements.yml
ansible-playbook -i ansible/inventory/localhost.yml ansible/workstation.yml --check --diff
ansible-playbook -i ansible/inventory/localhost.yml ansible/workstation.yml
```

The qmake workflow defaults to
`/opt/qt-everywhere-src-5.15.2/qtbase/bin/qmake`. That project-specific Qt SDK
is not downloaded because its build options and licensing are external to this
repository. Override it with `-e qt_qmake_path=/path/to/qmake`.

Zed and Neovide are installed from pinned upstream x86_64 release archives.
Zed uses its native SSH Remote Development support; Neovide uses the
loopback-only helpers documented in `home/dot_local/bin/README.md`.
