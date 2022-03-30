{
  datacenters ? ["dc1"],
  type ? "batch",
  driver ? ["podman" "docker"],
  namespace ? "default",
  version ? "latest",
}: {
  inputs,
  cell,
}: let
  # based on https://github.com/MISP/misp-docker/blob/master/docker-compose.yml
  env.misp = {
    MYSQL_HOST = "\${MYSQL_HOST}";
    MYSQL_DATABASE = "\${MYSQL_DATABASE}";
    MYSQL_USER = "\${MYSQL_USER}";
    MYSQL_PASSWORD = "\${MYSQL_PASSWORD}";
    MISP_ADMIN_EMAIL = "\${MISP_ADMIN_EMAIL}";
    MISP_ADMIN_PASSPHRASE = "\${MISP_ADMIN_PASSPHRASE}";
    MISP_BASEURL = "\${MISP_BASEURL}";
    POSTFIX_RELAY_HOST = "\${POSTFIX_RELAY_HOST}";
    TIMEZONE = "\${TIMEZONE}";
  };

  env.mysql = {
    MYSQL_DATABASE = "\${MYSQL_DATABASE}";
    MYSQL_USER = "\${MYSQL_USER}";
    MYSQL_PASSWORD = "\${MYSQL_PASSWORD}";
    MYSQL_ROOT_PASSWORD = "\${MYSQL_ROOT_PASSWORD}";
  };

  resources = {
    memory = 1024;
    cpu = 3000;
  };
in {
  job.misp = {
    inherit datacenters type namespace;
    group.container = {
      # count = 1;
      # volume.misp = {
      #   type = "host";
      #   read_only = false;
      #   source = "misp";
      # };
      task.misp = {
        inherit driver resources;
        env = env.misp;
        config = {
          image = "misp:${version}";
        };
      };
      task.misp-mysql = {
        inherit driver resources;
        env = env.mysql;
        config = {
          image = "mysql/mysql-server:5.7";
        };
      };
    };
  };
}
