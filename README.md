## Installation

1. Install `nix`:

```
# Using the Determinate Nix Installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Install `home-manager` with `nix`:

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
```

3. Git clone this to your home directory:  

```
# E.g. In /Users/kai
git clone git@github.com:kw7oe/dotfiles.git
```

3. By default, `home-manager` looks for `home.nix` in `$HOME/.config/home-manager.home.nix`. 
For example, `/Users/kai/.config/home-manager/home.nix`. Let's change it by modifying the 
`HOME_MANAGER_CONFIG` env var:

```
export HOME_MANAGER_CONFIG=$HOME/kai/dotfiles/home.nix
```

4. Run `home-manager switch -b backup` to have `home-manager` setup your environment.
This will also backup any dotfiles that clash with the one configured in `home.nix`, e.g.
`~/.zshrc`.
