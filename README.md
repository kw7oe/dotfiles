## Installation

1. Git clone this to your home directory:

```
# E.g. In /Users/kai
git clone git@github.com:kw7oe/dotfiles.git
```

1. Install `nix`:

```
# Using the Determinate Nix Installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

1. By default, `home-manager` looks for `home.nix` in `$HOME/.config/home-manager.home.nix`.
For example, `/Users/kai/.config/home-manager/home.nix`. Let's create a symbolic link to
the `home.nix` we want:

```
mkdir -p $HOME/.config/home-manager
ln -s $HOME/dotfiles/mac-home.nix $HOME/.config/home-manager/home.nix
```

1. Since we use unstable nix packages, let's install that as well first:

```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --update
```

1. Install `home-manager` with `nix`:

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

1. Run `home-manager switch -b backup` to have `home-manager` setup your environment.
This will also backup any dotfiles that clash with the one configured in `home.nix`, e.g.
`~/.zshrc`.

## References

This setup is not possible without the following resources:

- Learning about nix and home-manager:
  - [Zero to Nix Learn More](https://zero-to-nix.com/start/learn-more)
  - [Nixology](https://www.youtube.com/playlist?list=PLRGI9KQ3_HP_OFRG6R-p4iFgMSK1t5BHs)
  - [Declarative management of dotfiles with Nix and Home Manager](https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager)
  - [Tidying up your $HOME with Nix](https://juliu.is/tidying-your-home-with-nix/)
- Nix configuratino I refer to for setting up my home-manager:
  - [Søren nvim setup](https://github.com/nerosnm/config/blob/main/users/modules/nvim/default.nix)
  - [Nick home-manager setup](https://github.com/nicholastmosher/dotfiles/tree/master/nix/users/modules)
- For setting up Neovim: [Rust and Neovim - A Thorough Guide and Walkthrough](https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/)

Huge thanks to all of them!
