{ pkgs, ... }:
  let
    luaPlugin = plugin: configPath: {
      inherit plugin;
      type = "lua";
      config = builtins.readFile configPath;
    };

    luaPluginInline = plugin: config: {
      inherit plugin config;
      type = "lua";
    };
in {

  home.packages = with pkgs; [
    ripgrep
    htop
    watch
    jq
    mdcat

    # While I tried to adopt setting up rust only in 
    # a project with flake.nix, unfortunately, the nvim,
    # rust-analyzer integration doesn't work well. 
    # 
    # It can't autocomplete or show docs for the standard 
    # libray modules...
    #
    # Hence falling back to use rust system wide first.
    rustup
    erlang
    elixir
    nodejs

    flyctl
  ];

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    history = {
      path = "$HOME/.zsh_history";
      size = 50000;
      save = 50000;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.3";
          sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
        };
      }
      {
        name = "zsh-z";
        src = pkgs.fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "master";
          sha256 = "I9kmItK2ZmAnYXcYaTA2hTvRGKAK0dq1Kbs6UDcXoK4=";
        };
      }
    ];

    sessionVariables = rec {
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
      EDITOR = "vim";
      VISUAL = EDITOR;
      GIT_EDITOR = EDITOR;
      PGDATA="$HOME/.pg";
    };
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    sensibleOnTop = false;
    extraConfig = ''
    unbind r
    bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded tmux.conf"
    '';
    plugins = with pkgs.tmuxPlugins; [
      onedark-theme
    ];
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
    let mapleader = " "
    let loaded_netrw = 1
    let loaded_netrwPlugin = 1

    set termguicolors
    colorscheme onedark

    autocmd BufWritePre * :%s/\s\+$//e
    au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
    au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
    au BufRead,BufNewFile mix.lock set filetype=elixir
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      onedark-vim
      nvim-web-devicons
      vim-surround

      rust-vim
      # rust-tools-nvim
      vim-elixir

      (luaPluginInline nvim-comment "require('nvim_comment').setup()")
      (luaPlugin nvim-tree-lua ./config/nvim-tree.lua)
      (luaPlugin lualine-nvim ./config/lualine.lua)
      (luaPlugin telescope-nvim ./config/telescope.lua)
      (luaPlugin vim-floaterm ./config/floaterm.lua)

      (luaPlugin (nvim-treesitter.withPlugins (
          # https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/development/tools/parsing/tree-sitter/grammars
          plugins:
          with plugins; [
            tree-sitter-elixir
            tree-sitter-rust
            tree-sitter-lua
            tree-sitter-vim
            tree-sitter-html
            tree-sitter-yaml
            tree-sitter-json
            tree-sitter-bash
            tree-sitter-javascript
            tree-sitter-nix
            tree-sitter-typescript
            tree-sitter-c
            tree-sitter-sql
            tree-sitter-dockerfile
          ]
          )) ./config/nvim-treesitter.lua)

        # LSP
        nvim-lspconfig
        (luaPluginInline mason-nvim "require('mason').setup()")
        (luaPlugin mason-lspconfig-nvim ./config/mason-lspconfig-nvim.lua)

        cmp-nvim-lua
        cmp-nvim-lsp-signature-help
        cmp-vsnip
        cmp-path
        cmp-buffer
        vim-vsnip

        (luaPlugin nvim-cmp ./config/nvim-cmp.lua)
        (luaPlugin cmp-nvim-lsp ./config/cmp-nvim-lsp.lua)
      ];
    };
  }
