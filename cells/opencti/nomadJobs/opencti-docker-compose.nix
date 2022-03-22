{
  datacenters ? ["dc1"],
  type ? "batch",
  driver ? ["podman" "docker"],
  namespace ? "default",
}: {
  # based on https://github.com/OpenCTI-Platform/docker/blob/master/docker-compose.yml
  job.opencti = {
    inherit datacenters type namespace;
    group.container = {
      count = 1;
      volume.opencti = {
        type = "host";
        read_only = false;
        source = "opencti";
      };
      task.opencti = {
        inherit driver;

        volume_mount = {
          volume = "opencti";
          destination = "/var/lib/private/opencti";
          read_only = false;
        };

        resources = {
          memory = 1100;
          cpu = 3000;
        };

        config = {};
      };
    };
  };
}
