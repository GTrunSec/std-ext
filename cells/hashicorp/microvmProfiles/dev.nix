{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.hostName = "nomad-dev";
  microvm = {
    hypervisor = "qemu";
    interfaces = [
      {
        type = "user";
        id = "vm-qemu-1";
        mac = "00:02:00:01:01:00";
      }
    ];
    volumes = [
      {
        mountPoint = "/var";
        image = "/tmp/user.img";
        size = 2048;
      }
    ];
  };
}
