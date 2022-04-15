{
  config,
  lib,
  pkgs,
  packages,
  ...
}: {
  networking.firewall.enable = lib.mkForce false;
  networking.nameservers = ["192.168.1.1" "1.1.1.1"];
  services.nomad = {
    package = packages.nomad;
  };
}
