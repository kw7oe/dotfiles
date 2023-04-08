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

    postgresConf =
      pkgs.writeText "postgresql.conf"
      ''
        # Add Custom Settings
        log_min_messages = warning
        log_min_error_statement = error
        log_min_duration_statement = 100  # ms
        log_connections = on
        log_disconnections = on
        log_duration = on
        #log_line_prefix = '[] '
        log_timezone = 'UTC'
        log_statement = 'all'
        log_directory = 'pg_log'
        log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
        logging_collector = on
        log_min_error_statement = error
        '';

in {
    home.username = "\${USER}"; 
    home.homeDirectory = /. + builtins.toPath "/\${HOME}"; 
    home.stateVersion = "22.11";
    programs.home-manager.enable = true;

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

      pkgs.zookeeper
      pkgs.apacheKafka
      pkgs.postgresql_15
    ];


    programs.bat.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      initExtra = ''
      ${builtins.readFile ./shell/function.sh}
      '';
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
        HOME_MANAGER_CONFIG = "$HOME/dotfiles/home.nix";
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
        EDITOR = "vim";
        VISUAL = EDITOR;
        GIT_EDITOR = EDITOR;
        PGDATA="$HOME/.pg";
        PGCONF="${postgresConf}";
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
