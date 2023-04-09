{ pkgs, ... }: {
  home.packages = [
    pkgs.zookeeper
    pkgs.apacheKafka
    pkgs.postgresql_15
  ];
}
