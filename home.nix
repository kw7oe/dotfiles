{ pkgs, ... }: {
  home.username = "kai"; 
  home.homeDirectory = "/Users/kai"; 
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;


  home.packages = [    
    pkgs.ripgrep
    pkgs.htop
    pkgs.watch
    pkgs.jq
    pkgs.tmux
    pkgs.neovim
  ];
}
