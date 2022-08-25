{
  config,
  lib,
  pkgs,
  ...
}: {
  system.stateVersion = "22.05";

  networking.hostName = "nomad-dev";

  users.users.root.password = "";

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
}
