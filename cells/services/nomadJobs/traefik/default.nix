{
  datacenters ? ["dc1"],
  type ? "system",
  namespace ? "default",
  version ? "2.6",
}: {
  job.http-ingress-connect = {
    inherit datacenters type namespace;
    group.edge = {
      network = {
        mode = "bridge";

        port.web = {
          static = 8901;
          to = 8901;
        };

        port.websecure = {
          static = 8902;
          to = 8902;
        };

        # Treafik dashboard
        port.api = {
          static = 8909;
          to = 8909;
        };
      };
      service = {
        name = "http-ingress-connect";
        port = "web";
        tags = ["web" "websecure"];

        connect = {
          native = true;
        };
      };

      task.traefik = {
        driver = "docker";
        config = {
          image = "traefik:${version}";
          volumes = [
            "local/traefik.toml:/etc/traefik/traefik.toml"
          ];
        };
      };

      template = [
        {
          destination = "local/traefik.toml";
          left_delimiter = "<<";
          right_delimiter = ">>";
          data = builtins.fromTOML (builtins.readFile ./http.toml);
        }
      ];
      resources = {
        cpu = 100;
        memory = 128;
      };
    };
  };
}
