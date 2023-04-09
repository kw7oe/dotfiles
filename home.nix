{ pkgs, ... }: {
    home.username = "\${USER}"; 
    home.homeDirectory = /. + builtins.toPath "/\${HOME}"; 
    home.stateVersion = "22.11";
    programs.home-manager.enable = true;

    imports = [
      ./common.nix
      ./modules/postgresql.nix
    ];

    programs.zsh = {
      initExtra = ''
      ${builtins.readFile ./modules/postgresql.sh}
      '';
    };

}
