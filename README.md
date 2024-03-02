# Public Dotfiles

This is where I keep all (most) of my reusable configuration files.

The files are managed by [`stow`](https://www.gnu.org/software/stow/). I use quite a number of starter configs from
official docs or those publicly available and extend or customize them per my needs.

Feel free to peek and hopefully you find something you like.

And oh, **I use Arch BTW 😉**.

### Things to do before starting stow

- Install Neovim.
- Install NvChad.
- Open neovim and reply **n** to the question from NvChad about creating a custom
  config.
- Install `stow` using your package manager.

### Usage

Clone this repo the `$HOME` directory and `cd` into the root of the repo.

```sh
cd $HOME
git clone git@github.com:chee-zaram/dotfiles.pub.git
cd dotfiles.pub
```

Simply run in the `dotfiles.pub` directory.

```sh
stow .
```

You might get some errors about conflicts. Do not adopt the non-stow-managed
versions. Simply rename or move the files or directories somewhere else, and
attempt to run `stow .` it runs successfully without errors.

Make sure to go through the config files to find out what dependencies are
specified in the config files you'll be using and install them.
