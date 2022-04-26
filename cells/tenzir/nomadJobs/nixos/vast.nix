{
  flake ? "",
  datacenters ? ["dc1"],
  type ? "batch",
  namespace ? "default",
}: let
  volume.vast = {
    type = "host";
    read_only = false;
    source = "vast";
  };

  volume_mount = {
    volume = "vast";
    destination = "/var/lib/private/vast";
    read_only = false;
  };
  resources = {
    memory = 1100;
    cpu = 3000;
  };
in {
  job.vast = {
    inherit datacenters type namespace;
    group.nixos = {
      # count = 1;
      inherit volume;
      task.vast = {
        driver = "nix";

        inherit volume_mount resources;

        config = {
          nixos = flake;
        };

        service = {
          # name         = "api";
          provider = "nomad";
          # port         = "api";
        };
      };
    };
  };
}
