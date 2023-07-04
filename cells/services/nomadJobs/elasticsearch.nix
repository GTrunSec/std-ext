{
  datacenters ? ["dc1"],
  type ? "service",
  driver ? ["podman" "docker"],
  namespace ? "default",
  version ? "7.17.1",
  task ? "prod",
}: let
  resources = {
    memory = 1024;
    cpu = 3000;
  };
  network = {
    port.elasticsearch = {
      static = 9200;
      to = 9200;
    };
  };
  service = {
    name = "elasticsearch";
    port = 9200;
  };
in {
  job.elasticsearch = {
    inherit datacenters type namespace;
    group.container = {
      count = 1;
      inherit network service;
      task.${task} = {
        inherit resources driver;
        config = {
          image = "docker.elastic.co/elasticsearch/elasticsearch:${version}";

          ports = ["elasticsearch"];
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
