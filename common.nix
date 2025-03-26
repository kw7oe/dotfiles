{ pkgs, ... }:
  let
    pkgsUnstable = import <nixpkgs-unstable> {};

    luaPlugin = plugin: configPath: {
      inherit plugin;
      type = "lua";
      config = builtins.readFile configPath;
    };

    luaPluginInline = plugin: config: {
      inherit plugin config;
      type = "lua";
    };

    # catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    #   pluginName = "catppuccin";
    #   version = "latest";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "dreamsofcode-io";
    #     repo = "catppuccin-tmux";
    #     rev = "b4e0715";
    #     sha256 = "sha256-FJHM6LJkiAwxaLd5pnAoF3a7AE1ZqHWoCpUJE0ncCA8=";
    #   };
    # };

    # erlang = pkgs.erlang.override {
    #   version = "26.2.1";
    #   sha256 = "sha256-GzF/cpTUe5hoocDK5aio/lo8oYFeTr+HkftTYpQnOdA=";
    # };
    # beamPkg = pkgsUnstable.beam.packagesWith erlang;
    # elixir = beamPkg.elixir_1_15;
in {

  home.packages = with pkgsUnstable; [
    ripgrep
    btop
    watch
    jq
    mdcat
    gnuplot
    lima
    ffmpeg

    minio

    # While I tried to adopt setting up rust only in
    # a project with flake.nix, unfortunately, the nvim,
    # rust-analyzer integration doesn't work well.
    #
    # It can't autocomplete or show docs for the standard
    # libray modules...
    #
    # Hence falling back to use rust system wide first.
    rustup
    beam.packages.erlang_27.elixir_1_18
    nodejs
  ];

  programs.home-manager.enable = true;
  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      path = "$HOME/.zsh_history";
      size = 50000;
      save = 50000;
    };
    initExtra =''
    # Manually source fzf due to this issue:
    # https://github.com/nix-community/home-manager/issues/6704
    source <(fzf --zsh)
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
    '';

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
          sha256 = "sha256-CJjPjXIHUpEcKoExyskVeJGWXAjr2Pix3Uszuy/veGc=";
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    sensibleOnTop = true;
    extraConfig = ''
    unbind r
    set -g default-terminal "tmux-256color"
    set -ga terminal-overrides ",xterm-256color:RGB"

    bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded tmux.conf"

    # prefix - a to switch zoom on pane
    bind -r a select-pane -t .+1 \;  resize-pane -Z

    # set vi-mode
    set-window-option -g mode-keys vi
    # keybindings
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';
    plugins = with pkgs; [
      # tmuxPlugins.onedark-theme
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin
      tmuxPlugins.yank
      # catppuccin-tmux
    ];
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
    let mapleader = " "
    let loaded_netrw = 1
    let loaded_netrwPlugin = 1

    set relativenumber

    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufWritePre * lua vim.lsp.buf.format()
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      (luaPlugin onedark-nvim ./config/theme.lua)
      nvim-web-devicons
      vim-surround

      vim-tmux-navigator
      rust-tools-nvim
      elixir-tools-nvim
      vim-markdown-toc

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
            tree-sitter-heex
            tree-sitter-eex
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
