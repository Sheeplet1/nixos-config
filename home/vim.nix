{ pkgs, ... }:
{
  enable = true;
  plugins = [
    pkgs.vimPlugins.Syntastic
    pkgs.vimPlugins.Tagbar
    pkgs.vimPlugins.fzfWrapper
    pkgs.vimPlugins.fzf-vim
    pkgs.vimPlugins.gruvbox
  ];
  extraConfig = ''
    syntax on 
    filetype on
    set expandtab
    set bs=2
    set tabstop=2
    set shiftwidth=2
    set autoindent
    set smartindent
    set smartcase
    set ignorecase
    set modeline
    set nocompatible
    set encoding=utf-8
    set hlsearch
    set history=700
    set t_Co=256
    set termguicolors
    set background=dark
    set tabpagemax=1000
    set ruler
    set nojoinspaces
    set shiftround
    set relativenumber
    set nonumber

    set nolbr
    set tw=0

    colorscheme gruvbox

    let mapleader=" "

    " Disable highlight when <leader><cr> is pressed
    map <silent> <leader><cr> :noh<cr>

    " Move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " Toggle paste mode on and off
    map <leader>v :setlocal paste!<cr>

    " Tagbar shortcut
    map <leader>0 :TagbarToggle<CR>

    " File finder
    nmap <leader>t :FZF<CR>
    nmap <leader>h :Ag<CR>
  '';
}
