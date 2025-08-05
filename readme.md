# Introduction

This repository contains utilities to help replicate a development environment across machines.

# Installation

To install, clone the repository and run the setup script with the following commands:

```bash
$ git clone https://github.com/wfa207/dotfiles.git
$ cd dotfiles
$ python -m setup
```

The script is interactive, so expect to be prompted for input while it runs. Moreover, individual scripts can be run by executing:

```bash
$ python -m setup.<path>.<to>.<desired>.<script>
```

For example, if we wanted to setup the Python development environment (not included in the main setup script above), we could run

```bash
$ python -m setup.languages.python
```

# Terminal Utilities

## iTerm

iTerm settings should be updated automatically via the setup script. If for whatever reason, the settings are **not** updated, there are several items to check:

- Enable preference-loading from the `setup/terminal/iterm/config_files` folder via the settings in `General > Preferences` pane in iTerm
  - The "Load preferences from a custom folder or URL" option should be checked
  - Make sure to set "Save Changes" to `Automatically`
- Set iTerm's font to a Powerline-enabled font (i.e. Inconsolata) for Powerline-Shell to display correctly
- Color schemes can be imported from the `color_schemes/` directory

## Powerline

Powerline helps format the terminal prompt to provide more information on repo status, working directory, etc.

**Note**: When switching between Python versions with `pyenv`, you can re-run the `powerline-shell` [installation script](https://github.com/b-ryan/powerline-shell?tab=readme-ov-file#setup) with the active Python version

## Tmux

Tmux is a powerful tool that essentially splits a single terminal window into as many panes and windows as you want. It also persists "sessions" even after you close the window (unless the Tmux session is explicitly destroyed).

# Supported Editors

## VSCode

VS Code is currently my preferred editor, setup with VIM key bindings given that's what I'm accustomed to and the Synthwave theme, which I think is pretty nifty.

## Vim

I've opted to use VSCode's Vim emulation over traditional Vim given the more streamlined extension management in VSCode. I've kept the Vim setup, nonetheless, and the following instructions might still prove helpful if there's a reason to pick up Vim again.

Check if your version of Vim has the +clipboard option, by running `$ vim --version`. If it isn't enabled, then you'll have to install the latest version of Vim; you can do this by running `$ brew install vim` (brew should install vim with the `+clipboard` option enabled):

Note: It may be smart to add the `--with-client-server` option, which supports X11 clipboard, allowing you to copy to the system clipboard even [when ssh'd into a machine](http://www.markcampbell.me/2016/04/12/setting-up-yank-to-clipboard-on-a-mac-with-vim.html). Homebrew doesn't enable this by default, and I haven't yet looked into adding this in this repo.

# Supported Languages

Languages can be setup separately by running:

```bash
$ cd dotfiles
$ python -m setup.languages
```

Languages are not yet packaged with the main setup script, as different environments may require different language-specific tooling that the included script is opinionated about.

## Python

The included Python environment script will install:

- [Poetry](https://python-poetry.org/) and [Pyenv](https://github.com/pyenv/pyenv) for dependency and version management, respectively
- Several Python versions, including `2.7.15` and versions spanning `3.6` to `3.7`
- Language servers for better code introspection (i.e. [Jedi](https://jedi.readthedocs.io/en/latest/) / [Python Language Server](https://github.com/palantir/python-language-server))

## Javascript

The included Javascript environment script will install:

- [NodeJS](https://nodejs.org/en/) as the core backend framework
- [Yarn](https://yarnpkg.com/) for package management
- [NVM](https://github.com/nvm-sh/nvm) for version management
- [Typescript](https://www.typescriptlang.org/)
