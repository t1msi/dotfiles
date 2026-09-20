# Zed

The global tasks expose the same `qmake-workflow` commands used by Neovim and
the terminal. They run on the remote machine when the project is opened through
Zed's native Remote Development support.

Open the Remote Projects dialog with `Ctrl+Alt+Shift+O`, choose **Connect New
Server**, and enter an SSH destination from your machine-local
`~/.ssh/config`. Zed installs its matching headless server and runs language
servers, terminals, and tasks on that host.

`settings.json` is intentionally unmanaged so Zed can record verified SSH
connections and host-specific project paths without putting them in this
repository or losing them on the next chezmoi apply. Do not install the
third-party `remote-ssh` extension for this workflow.
