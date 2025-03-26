{ pkgs, ... }: {
    home.username = "kai";
    home.homeDirectory = "/Users/kai";
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;

    imports = [
      ./common.nix
      # ./modules/database.nix
    ];

    programs.zsh = {
      initExtra = ''
      ${builtins.readFile ./modules/database.sh}

      # It's unfortunate that I need this...
      #
      # Without this, my rust-analyzer can't seem to load any standard library type/docs/autocomplete
      # even I have rust-src setup and the rust-analyzer is using the correct one.
      #
      # It seems to be related to the rust-src at /nix/store is read only.
      export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
      '';
    };

}
