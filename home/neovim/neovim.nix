{ inputs, pkgs, ... }:
{
  enable = true;
  defaultEditor = true;
  extraPackages = with pkgs; [
    # LSPs added here are added globally. Preferably, we install required LSPs per project via
    # flake.nix
    prettierd

    shfmt
    shellcheck
    bash-language-server

    lua-language-server
    stylua

    # Python
    # ruff
    # pyright
    # isort

    tailwindcss-language-server
    # nodePackages.typescript-language-server
    # html-language-server
    # css-lsp

    # svelte-language-server

    # rust-analyzer

    # gopls
    # gofumpt
    # goimports-reviser
    # gomodifytags
    # golines
    # gotests

    nixd
  ];
}
