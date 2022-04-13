{
  config,
  lib,
  pkgs,
  packages,
  ...
}: {
  services.nomad = {
    package = packages.nomad;
  };
}
