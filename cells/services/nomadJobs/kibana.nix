{
  datacenters ? [ "dc1" ],
  type ? "service",
  driver ? [
    "podman"
    "docker"
  ],
  namespace ? "default",
  version ? "7.17.1",
  task ? "prod",
}:
let
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
in
{
  job.kibana = {
    inherit datacenters type namespace;

    group.container = {
      count = 1;

      inherit network service;

      task.${task} = {
        inherit resources driver;

        config = {
          image = "docker.elastic.co/kibana/kibana:${version}";
          ports = [ "kibana" ];
        };

        env = {
          ELASTICSEARCH_HOSTS = "http://127.0.0.1:9200";
        };
      };
    };
  };
}
