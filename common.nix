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

  home.packages = [
    pkgs.ripgrep
    pkgs.htop
    pkgs.watch
    pkgs.jq
    pkgs.mdcat

    pkgs.rustup
    pkgs.erlang
    pkgs.elixir
    pkgs.nodejs
  ];

  programs.bat.enable = true;

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
          sha256 = "MHb9Q7mwgWAs99vom6a2aODB40I9JTBaJnbvTYbMwiA=";
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
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      onedark-vim
      nvim-web-devicons

      rust-vim

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
