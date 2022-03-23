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
      # volume.opencti = {
      #   type = "host";
      #   read_only = false;
      #   source = "opencti";
      # };
      task.opencti-platform = {
        inherit driver;

        config = {
          image = "opencti/platform:5.2.1";
        };

        env = {
          NODE_OPTIONS = "--max-old-space-size = 8096";
          APP__PORT = 8080;
          APP__ADMIN__EMAIL = "\${OPENCTI_ADMIN_EMAIL}";
          APP__ADMIN__PASSWORD = "\${OPENCTI_ADMIN_PASSWORD}";
          APP__ADMIN__TOKEN = "\${OPENCTI_ADMIN_TOKEN}";
          APP__APP_LOGS__LOGS_LEVEL = "error";
          REDIS__HOSTNAME = "redis";
          REDIS__PORT = 6379;
          ELASTICSEARCH__URL = "http://elasticsearch:9200";
          MINIO__ENDPOINT = "minio";
          MINIO__PORT = 9000;
          MINIO__USE_SSL = false;
          MINIO__ACCESS_KEY = "\${MINIO_ROOT_USER}";
          MINIO__SECRET_KEY = "\${MINIO_ROOT_PASSWORD}";
          RABBITMQ__HOSTNAME = "rabbitmq";
          RABBITMQ__PORT = 5672;
          RABBITMQ__PORT_MANAGEMENT = 15672;
          RABBITMQ__MANAGEMENT_SSL = false;
          RABBITMQ__USERNAME = "\${RABBITMQ_DEFAULT_USER}";
          RABBITMQ__PASSWORD = "\${RABBITMQ_DEFAULT_PASS}";
          SMTP__HOSTNAME = "\${SMTP_HOSTNAME}";
          SMTP__PORT = 25;
          PROVIDERS__LOCAL__STRATEGY = "LocalStrategy";
        };
        # volume_mount = {
        #   volume = "opencti";
        #   destination = "/var/lib/private/opencti";
        #   read_only = false;
        # };
        resources = {
          memory = 1100;
          cpu = 3000;
        };
      };
    };
  };
}
