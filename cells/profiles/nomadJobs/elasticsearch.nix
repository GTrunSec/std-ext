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
  volume.elasticsearch = {
    type = "host";
    read_only = false;
    source = "elasticsearch";
  };
  network = {
    port.http = {
      static = 9200;
      to = 9200;
    };
  };
  service = {
    name = "http";
    port = 9200;
  };
in {
  job.elasticsearch = {
    inherit datacenters type namespace;
    group.container = {
      count = 1;
      inherit network service;
      task.elasticsearch = {
        inherit resources driver;
        config = {
          image = "docker.elastic.co/elasticsearch/elasticsearch:${version}";

          ports = ["http"];
          # args = [
          #   "-Ehttp.port=9200"
          # ];
        };
        env = {
          "bootstrap.memory_lock" = "true";
          "ES_JAVA_OPTS" = "-Xms512m -Xmx512m";
          "discovery.type" = "single-node";
        };
      };
    };
  };
}
