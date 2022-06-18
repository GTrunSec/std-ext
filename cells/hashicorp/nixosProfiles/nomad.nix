{
  lib,
  packages,
  ...
}: {
  networking.firewall.enable = lib.mkForce false;

  services.nomad = {
    package = packages.nomad;
  };

  microvm.forwardPorts = [
    {
      from = "host";
      host.port = 4646;
      guest.port = 4646;
    }
  ];
}
