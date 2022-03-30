{version ? "5.2.3"}: let
  # based on https://github.com/OpenCTI-Platform/docker/blob/master/docker-compose.yml
  env.opencti-common = {
    OPENCTI_URL = "http://opencti:8080";
    OPENCTI_TOKEN = "\${OPENCTI_ADMIN_TOKEN}";
    WORKER_LOG_LEVEL = "info";
  };

  env.opencti =
    {
      NODE_OPTIONS = "--max-old-space-size=8096";
      APP__PORT = "8080";
      APP__ADMIN__EMAIL = "\${OPENCTI_ADMIN_EMAIL}";
      APP__ADMIN__PASSWORD = "\${OPENCTI_ADMIN_PASSWORD}";
      APP__ADMIN__TOKEN = "\${OPENCTI_ADMIN_TOKEN}";
      APP__APP_LOGS__LOGS_LEVEL = "error";
      REDIS__HOSTNAME = "redis";
      REDIS__PORT = "6379";
      ELASTICSEARCH__URL = "http://elasticsearch:9200";
      SMTP__HOSTNAME = "\${SMTP_HOSTNAME}";
      SMTP__PORT = "25";
      PROVIDERS__LOCAL__STRATEGY = "LocalStrategy";
    }
    // env.rabbitmq
    // env.minio;

  env.minio = {
    MINIO__ENDPOINT = "minio";
    MINIO__PORT = "9000";
    MINIO__USE_SSL = "false";
    MINIO__ACCESS_KEY = "\${MINIO_ROOT_USER}";
    MINIO__SECRET_KEY = "\${MINIO_ROOT_PASSWORD}";
  };

  env.rabbitmq = {
    RABBITMQ__HOSTNAME = "rabbitmq";
    RABBITMQ__PORT = "5672";
    RABBITMQ__PORT_MANAGEMENT = "15672";
    RABBITMQ__MANAGEMENT_SSL = "false";
    RABBITMQ__USERNAME = "\${RABBITMQ_DEFAULT_USER}";
    RABBITMQ__PASSWORD = "\${RABBITMQ_DEFAULT_PASS}";
  };

  env.connector-history =
    {
      CONNECTOR_ID = "\${CONNECTOR_HISTORY_ID}"; # Valid UUIDv4
      CONNECTOR_TYPE = "STREAM";
      CONNECTOR_NAME = "History";
      CONNECTOR_SCOPE = "history";
    }
    // env.opencti-common
    // env.connector-common;

  env.connector-common = {
    CONNECTOR_CONFIDENCE_LEVEL = 15; # From 0 (Unknown) to 100 (Fully trusted)
    CONNECTOR_LOG_LEVEL = "info";
  };

  env.connector-export-file-stix =
    {
      CONNECTOR_ID = "\${CONNECTOR_EXPORT_FILE_STIX_ID}";
      CONNECTOR_TYPE = "INTERNAL_EXPORT_FILE";
      CONNECTOR_NAME = "ExportFileCsv";
      CONNECTOR_SCOPE = "text/csv";
    }
    // env.opencti-common
    // env.connector-common;

  env.connector-export-file-csv =
    {
      CONNECTOR_ID = "\${CONNECTOR_EXPORT_FILE_CSV_ID}";
      CONNECTOR_TYPE = "INTERNAL_EXPORT_FILE";
      CONNECTOR_NAME = "ExportFileCsv";
      CONNECTOR_SCOPE = "text/plain";
    }
    // env.opencti-common
    // env.connector-common;

  env.connector-export-file-txt =
    {
      CONNECTOR_ID = "\${CONNECTOR_EXPORT_FILE_TXT_ID}";
      CONNECTOR_TYPE = "INTERNAL_EXPORT_FILE";
      CONNECTOR_NAME = "ExportFileTxt";
      CONNECTOR_SCOPE = "text/plain";
    }
    // env.opencti-common
    // env.connector-common;

  env.connector-import-file-stix =
    {
      CONNECTOR_ID = "\${CONNECTOR_IMPORT_FILE_STIX_ID}";
      CONNECTOR_TYPE = "INTERNAL_IMPORT_FILE";
      CONNECTOR_NAME = "ImportFileStix";
      CONNECTOR_VALIDATE_BEFORE_IMPORT = "true"; # Validate any bundle before import
      CONNECTOR_SCOPE = "application/json,text/xml";
      CONNECTOR_AUTO = "true"; # Enable/disable auto-import of file
    }
    // env.opencti-common
    // env.connector-common;

  env.connector-import-document =
    {
      CONNECTOR_ID = "\${CONNECTOR_IMPORT_DOCUMENT_ID}";
      CONNECTOR_TYPE = "INTERNAL_IMPORT_FILE";
      CONNECTOR_NAME = "ImportDocument";
      CONNECTOR_VALIDATE_BEFORE_IMPORT = "true"; # Validate any bundle before import
      CONNECTOR_SCOPE = "application/pdf,text/plain,text/html";
      CONNECTOR_AUTO = "true"; # Enable/disable auto-import of file
      CONNECTOR_ONLY_CONTEXTUAL = "false"; # Only extract data related to an entity (a report, a threat actor, etc.)
      IMPORT_DOCUMENT_CREATE_INDICATOR = "true";
    }
    // env.opencti-common
    // env.connector-common;
in {
  version = "3";

  services.redis = {
    image = "redis:6.2.6";
    restart = "always";
    volumes = ["redisdata:/data"];
  };

  services.rabbitmq = {
    image = "rabbitmq:3.9-management";
    restart = "always";
    volumes = ["amqpdata:/var/lib/rabbitmq"];
    environment = env.rabbitmq;
  };

  services.minio = {
    image = "minio/minio:RELEASE.2022-02-26T02-54-46Z";
    restart = "always";
    volumes = ["s3data:/data"];
    ports = ["9000:9000"];
    environment = env.minio;
    command = "server /data";
    healthcheck = {
      test = ["CMD" "curl" "-f" "http://localhost:9000/minio/health/live"];
      interval = "30s";
      timeout = "20s";
      retries = 3;
    };
  };

  services.elasticsearch = {
    image = "docker.elastic.co/elasticsearch/elasticsearch:7.17.1";
    restart = "always";
    volumes = ["esdata:/usr/share/elasticsearch/data"];
    environment = [
      "discovery.type=single-node"
      "xpack.ml.enabled=false"
    ];
    ulimits = {
      memlock = {
        soft = "-1";
        hard = "-1";
      };
      nofile = {
        soft = 65536;
        hard = 65536;
      };
    };
  };

  services.opencti = {
    image = "opencti/platform:${version}";
    restart = "always";
    environment = env.opencti;
    depends_on = ["redis" "elasticsearch" "minio" "rabbitmq"];
    ports = ["8080:8080"];
  };

  services.worker = {
    image = "opencti/worker:${version}";
    restart = "always";
    environment = env.opencti-common;
    depends_on = ["opencti"];
    deploy = {
      mode = "replicated";
      replicas = 3;
    };
  };

  services.connector-history = {
    image = "opencti/connector-history:${version}";
    restart = "always";
    environment = env.connector-history;
    depends_on = ["opencti"];
  };

  services.connector-export-file-stix = {
    image = "opencti/connector-export-file-stix:${version}";
    restart = "always";
    environment = env.connector-export-file-stix;
    depends_on = ["opencti"];
  };

  services.connector-export-file-csv = {
    image = "opencti/connector-export-file-csv:${version}";
    restart = "always";
    environment = env.connector-export-file-csv;
    depends_on = ["opencti"];
  };

  services.connector-export-file-txt = {
    image = "opencti/connector-export-file-txt:${version}";
    restart = "always";
    environment = env.connector-export-file-txt;
    depends_on = ["opencti"];
  };

  services.connector-import-file-stix = {
    image = "opencti/connector-import-file-stix:${version}";
    restart = "always";
    environment = env.connector-import-file-stix;
    depends_on = ["opencti"];
  };

  services.connector-import-document = {
    image = "opencti/connector-import-document:${version}";
    restart = "always";
    environment = env.connector-import-document;
    depends_on = ["opencti"];
  };

  volumes = {
    esdata = {};
    s3data = {};
    redisdata = {};
    amqpdata = {};
  };
}
