{
  lib,
  packages,
  pkgs,
  ...
}: {
  networking.firewall.enable = lib.mkForce false;

  networking.firewall.allowedUDPPorts = [4647 4646];
  networking.firewall.allowedTCPPorts = [4647 4646];

  systemd.services.nomad.serviceConfig.SupplementaryGroups = ["podman" "docker"];

  services.nomad = {
    enable = true;
    dropPrivileges = false;
    package = packages.nomad;
    extraPackages = [pkgs.cni-plugins pkgs.consul pkgs.nixUnstable pkgs.podman];
    extraPlugins = [pkgs.nomad-driver-nix pkgs.nomad-driver-podman];
    settings = {
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
      client = {
        enabled = true;
        cni_path = "${pkgs.cni-plugins}/bin/";
      };
      vault = {
        enabled = true;
        address = "http://0.0.0.0:8200";
        token = "root";
      };

      plugin = {
        nix_driver.config.enabled = true;
        podman.config.enabled = true;
      };

      # FIXME: more generic way
      # consul.address = config.machine.services.nomad.consul.address;
    };
  };

  microvm.forwardPorts = [
    {
      from = "host";
      host.port = 4646;
      guest.port = 4646;
    }
  ];
}
