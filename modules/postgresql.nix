{ pkgs, ... }: {
  home.packages = [
    pkgs.postgresql_15
  ];
}
