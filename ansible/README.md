# Workstation provisioning

Run the repository bootstrap from an Ubuntu x86_64 graphical workstation:

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

The headless remote playbook also supports 64-bit Raspberry Pi OS/Debian 12 on
`aarch64`. It installs architecture-specific Neovim, chezmoi, Node.js, Rust,
NeoCMakeLSP, LuaLS, qmlls, Java, and Pkl builds. Zed remains on the local
workstation and connects through native Remote Development.

For a remote host, first make sure its non-root development user has Python 3,
SSH access, and sudo. Then use the dedicated wrapper with the same inventory and
key options as any other Ansible playbook:

```bash
# Run once on the device console.
sudo apt-get update
sudo apt-get install --yes openssh-server python3 python3-apt sudo
sudo systemctl enable --now ssh

# Run on the development workstation if the key is not installed yet.
chmod 600 "$HOME/.ssh/device"
ssh-copy-id -i "$HOME/.ssh/device.pub" developer@device-address
```

For Raspberry Pi OS, verify that the image is 64-bit Bookworm before running
Ansible:

```bash
dpkg --print-architecture # arm64
uname -m                  # aarch64
cat /etc/debian_version   # 12.x
```

Add a machine-local `Host devbox` entry to `~/.ssh/config` and verify it with
`ssh devbox`. Keep the key path in the untracked `~/.bashrc.local`:

```bash
export REMOTE_DEV_KEY_FILE="$HOME/.ssh/device"
```

Start a new terminal or source `~/.bashrc`, then provision the host:

```bash
remote-dev-workflow check \
  -i 'devbox,' \
  -u developer

remote-dev-workflow prepare \
  -i inventory-prod.yml \
  --limit devbox \
  -u developer
```

For a direct Raspberry Pi address, machine-local environment values keep the
command short:

```bash
export REMOTE_DEV_HOST="192.168.1.50"
export REMOTE_DEV_USER="pi"
export REMOTE_DEV_KEY_FILE="$HOME/.ssh/veresk_dev"

remote-dev-workflow prepare
```

`check` adds Ansible check mode and is useful after the host has been provisioned.
On a fresh host, run `prepare` directly because check mode cannot install the
downloaded tools needed by later validation tasks. `prepare` provisions the host,
copies only the tracked `home/` chezmoi source, previews its changes, and applies
it. Always use `--limit` when a shared production inventory contains hosts that
must not become development machines. The key, inventory, SSH aliases, and
passwords remain outside this repository.

The project-specific Qt 5.15 SDK is not installed on ARM. If an ARM Qt SDK is
available separately, set `QMAKE_BIN` in the remote user's `.bashrc.local`.

Node.js and its bundled npm are also installed from a pinned upstream archive.
Do not add Ubuntu's separate `npm` package: it conflicts with NodeSource and
other self-contained Node.js packages.
