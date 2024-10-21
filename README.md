# My Nix Configuration

## Installation

Start a nix-shell with git and neovim:

> nix-shell -p git neovim

Clone this repo:

> git clone git@github.com:Sheeplet1/nixos-config.git

Copy the device hardware configuration over to the system folder under `hardware`.

> cp /etc/nixos/hardware-configuration.nix <destination>

Then build:

> sudo nixos-rebuild switch --flake <flake-location>#<hardware>
