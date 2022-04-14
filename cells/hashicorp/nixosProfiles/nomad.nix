{
  config,
  lib,
  pkgs,
  packages,
  ...
}: {
  networking.firewall.enable = lib.mkForce false;

  services.nomad = {
    package = packages.nomad;
  };
}
