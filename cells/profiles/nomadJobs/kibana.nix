{
  datacenters ? ["dc1"],
  type ? "batch",
  driver ? ["podman" "docker"],
  namespace ? "default",
  version ? "7.17.1",
}: args: let
  resources = {
    memory = 1024;
    cpu = 3000;
  };
  network = {
    port.kibana = {
      static = 5601;
      to = 5601;
    };
  };
  service = {
    name = "kibana";
    port = 5601;
  };
in {
  job.elasticsearch = {
    inherit datacenters type namespace;
    group.container = {
      count = 1;
      inherit network service;
      task.kibana = {
        inherit resources driver;
        config = {
          image = "docker.elastic.co/kibana/kibana:${version}";

          ports = ["kibana"];
        };
        env = {
          ELASTICSEARCH_HOSTS = "http://127.0.0.1:9200";
        };
      };
    };
  };
}
