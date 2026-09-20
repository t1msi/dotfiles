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

QtCreator should use its own shadow directory, the same three qmake arguments,
`<buildDir>/staging/Course` as the executable, and `<buildDir>/staging` as the
working directory. Keep QtCreator `.user` files and generated compilation
databases out of Git.

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
