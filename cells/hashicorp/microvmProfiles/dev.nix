{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.hostName = "nomad-dev";

  users.users.root.password = "";

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
}
