# Developer commands

## qmake-workflow

`qmake-workflow` provides the same qmake build from a terminal, Neovim,
Zed, or an SSH session. Run it from the project root or any child directory;
it discovers `qgroundcontrol.pro` or a single `.pro` file in an ancestor.

The QGC defaults are:

```text
qmake: /opt/qt-everywhere-src-5.15.2/qtbase/bin/qmake
shadow build: <project>/build
arguments: CONFIG+=debug PROJECT_ARG=duck COURSE_USER_MODE=developer
executable: <project>/build/staging/Course
```

Typical use:

```bash
qmake-workflow configure
qmake-workflow build
qmake-workflow clean
qmake-workflow clear
qmake-workflow rebuild
qmake-workflow compdb
qmake-workflow lint
qmake-workflow run
qmake-workflow debug --some-application-argument
```

The QGC project normally requires its `course-qt-5.15.2` and
`course-openssl-1.1.1` packages. On a development host where the equivalent
dependencies are already present outside those packages, use the project's
explicit bypass rather than changing the shared default:

```bash
qmake-workflow configure CONFIG+=unsafe_course_deps
```

`compdb` intentionally performs a clean rebuild through Bear so the resulting
`build/compile_commands.json` is complete. `lint` accepts optional file regular
expressions understood by `run-clang-tidy`. Pass arbitrary extra qmake options
to `configure` and arbitrary make options or targets to `build` and `compdb`.

Environment variables listed by `qmake-workflow --help` override every default.
For a persistent machine-local override, export them from `~/.bashrc.local`.
For project-local qmake options, put one argument per line in
`.qmake-workflow.args`; these arguments are applied to every configure,
including the configure phase of `rebuild`.

`clean` runs the generated Make target and preserves qmake configuration.
`clear` deletes the shadow build directory. `rebuild` clears it, reruns qmake,
and performs a complete build. Clear operations refuse the source directory and
unmarked external directories.

QtCreator should use its own shadow directory, the same three qmake arguments,
`<buildDir>/staging/Course` as the executable, and `<buildDir>/staging` as the
working directory. Keep QtCreator `.user` files and generated compilation
databases out of Git.

## cmake-workflow

`cmake-workflow` provides equivalent editor-independent operations for CMake
projects. It discovers the nearest `CMakeLists.txt`, defaults to an out-of-source
`build` directory, and enables `compile_commands.json`:

```bash
cmake-workflow configure
cmake-workflow build
cmake-workflow test
cmake-workflow clean
cmake-workflow clear
cmake-workflow rebuild
```

`CMAKE_BUILD_DIR`, `CMAKE_BUILD_TYPE`, `CMAKE_GENERATOR`, and `CMAKE_JOBS`
override the defaults. Project-specific configure options belong in
`.cmake-workflow.args`, one argument per line. As with qmake, `clean` preserves
the configured build tree while `clear` removes it and `rebuild` recreates it.

Create a small C++17 CMake project that is ready for these commands with:

```bash
new-cmake-project ~/src/example
```

The generated smoke test runs through `cmake-workflow test`.

## Remote Neovide

Apply these dotfiles on both machines, then launch a remote project from the
local graphical workstation:

```bash
neovide-remote my-ssh-alias /home/me/src/project
```

The helper starts `~/.local/bin/nvim-remote-server` through SSH, forwards local
`127.0.0.1:6666` to the same loopback-only port on the remote host, and attaches
Neovide. Closing Neovide tears down the SSH session and the remote Neovim
process. SSH hosts and keys remain in machine-local `~/.ssh/config`.

Override a conflicting port without exposing either endpoint to the network:

```bash
NEOVIDE_LOCAL_PORT=7777 NVIM_REMOTE_PORT=7777 \
  neovide-remote my-ssh-alias ~/src/project -- --maximized
```

For a two-terminal workflow, run `nvim-remote-server /path/to/project` on the
remote machine and create an equivalent loopback SSH tunnel manually.

## Remote development

Prepare a host from the dotfiles checkout using Ansible-style connection
options. Configure the machine-local key path once, then preview and apply:

```bash
export REMOTE_DEV_KEY_FILE="$HOME/.ssh/device" # ~/.bashrc.local
remote-dev-workflow check \
  -i 'devbox,' -u developer
remote-dev-workflow prepare \
  -i 'devbox,' -u developer
```

An inventory file works as well. Limit shared inventories explicitly:

```bash
remote-dev-workflow prepare \
  -i inventory-prod.yml \
  --limit devbox \
  -u developer
```

For persistent terminal Neovim, connect through tmux:

```bash
nvim-ssh devbox /home/developer/src/project project
```

The remote checkout, compiler, language servers, task commands, and program all
stay on the remote host. SSH identities and host aliases remain in the local
`~/.ssh/config`.
