{ pkgs, ... }:
{
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  extraPackages = with pkgs; [
    # Adding LSP servers here since Mason binaries do not work on NixOS.
    prettierd

    shfmt
    shellcheck
    bash-language-server

    lua-language-server
    stylua

    ruff-lsp
    pyright
    isort

    tailwindcss-language-server
    typescript-language-server
    # html-language-server
    # css-lsp

    svelte-language-server

    rust-analyzer

    gopls
    gofumpt
    goimports-reviser
    gomodifytags
    golines
    gotests

    nixd
  ];
}
