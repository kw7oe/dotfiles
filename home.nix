{ pkgs, ... }: {
  home.username = "kai"; 
  home.homeDirectory = "/home/kai"; 
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;


  home.packages = [    
    pkgs.ripgrep
    pkgs.htop
    pkgs.watch
    pkgs.jq
  ];

  programs.bat.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
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
        name = "zsh-syntax-highligthing";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
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
    };
  };

  programs.tmux = {
    enable = true;
  };
 
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
    set termguicolors
    colorscheme onedark
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      onedark-vim
    ];
  };
}
