{
  datacenters ? ["dc1"],
  type ? "batch",
  driver ? ["podman" "docker"],
  namespace ? "default",
  version ? "5.2.2",
}: args: let
  resources = {
    memory = 1024;
    cpu = 3000;
  };
in {
  job.elasticsearch = {
    inherit datacenters type namespace;
    group.container = {
      # count = 1;
      # volume.opencti = {
      #   type = "host";
      #   read_only = false;
      #   source = "opencti";
      # };
    };
  };
}
