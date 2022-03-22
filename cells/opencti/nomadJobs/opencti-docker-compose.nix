{
  flake ? "",
  datacenters ? ["dc1"],
  type ? "batch",
  driver ? ["podman" "docker"],
  namespace ? "default",
}: {
  job.vast = {
    inherit datacenters type namespace;
    group.nixos = {
      count = 1;
      # volume.vast = {
      #   type = "host";
      #   read_only = false;
      #   source = "vast";
      # };
      task.vast = {
        inherit driver;

        volume_mount = {
          volume = "vast";
          destination = "/var/lib/private/vast";
          read_only = false;
        };

        resources = {
          memory = 1100;
          cpu = 3000;
        };

        config = {
          nixos = flake;
        };
      };
    };
  };
}
