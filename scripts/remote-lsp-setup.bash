#!/bin/bash
# :RemoteOpen rsync://user@remote-host/path/to/file.cpp
# :RemoteTreeBrowser rsync://user@remote-host/path/to/directory

sudo apt install rsync

pip3 install python-lsp-server python-lsp-ruff

sudo apt install clangd

# Install via rustup (recommended)
#rustup component add rust-analyzer

# Or via package manager
# Ubuntu 22.04+: sudo apt install rust-analyzer
#
# Ubuntu/Debian (if available in repos)
sudo apt install lua-language-server

# Install via pip
pip3 install cmake-language-server
