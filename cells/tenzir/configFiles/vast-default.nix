{
  db-directory,
  file-verbosity,
  ...
}: {
  endpoint = "localhost:42000";
  # The file system path used for persistent state.
  db-directory = "${db-directory}";

  # The file system path used for log files.
  log-file = "${db-directory}/server.log";

  file-format = "[%Y-%m-%dT%T.%e%z] [%n] [%l] [%s=%#] %v";

  # Configures the minimum severity of messages written to the log file.
  # Possible values= quiet, error, warning, info, verbose, debug, trace.
  # File logging is only available for commands that start a node (e.g., vast
  # start). The levels above 'verbose' are usually not available in release
  # builds.
  file-verbosity = "${file-verbosity}";

  # Whether to enable automatic log rotation. If set to false, a new log file
  # will be created when the size of the current log file exceeds 10 MiB.
  disable-log-rotation = false;

  # The size limit when a log file should be rotated.
  log-rotation-threshold = "10MiB";

  # Maximum number of log messages in the logger queue.
  log-queue-size = 1000000;

  # The sink type to use for console logging. Possible values= stderr,
  # syslog, journald. Note that 'journald' can only be selected on linux
  # systems, and only if VAST was built with journald support.
  # The journald sink is used as default if VAST is started as a systemd
  # service and the service is configured to use the journal for stderr,
  # otherwise the default is the unstructured stderr sink.
  # console-sink= stderr/journald

  # Mode for console log output generation. Automatic renders color only when
  # writing to a tty.
  # Possible values= always, automatic, never. (default automatic)
  console = "automatic";

  # Format for printing individual log entries to the console. For a list
  # of valid format specifiers, see spdlog format specification at
  # https=//github.com/gabime/spdlog/wiki/3.-Custom-formatting.
  console-format = "%^[%T.%e] %v%$";

  # Configures the minimum severity of messages written to the console.
  # For a list of valid log levels, see file-verbosity.
  console-verbosity = "info";

  # List of directories to look for schema files in ascending order of
  # priority.
  schema-dirs = [];

  # Additional directories to load plugins specified using `vast.plugins`
  # from.
  plugin-dirs = [];

  # The plugins to load at startup. For relative paths, VAST tries to find
  # the files in the specified `vast.plugin-dirs`. The special values
  # 'bundled' and 'all' enable autoloading of bundled and all plugins
  # respectively. Note= Add `example` or `/path/to/libvast-plugin-example.so`
  # to load the example plugin.
  plugins = [];

  # The unique ID of this node.
  node-id = "node";

  # Spawn a node instead of connecting to one.
  node = false;

  # The size of an index shard, expressed in number of events. This should
  # be a power of 2.
  max-partition-size = 1048576;

  # The number of index shards that can be cached in memory.
  max-resident-partitions = 10;

  # The number of index shards that are considered for the first evaluation
  # round of a query.
  max-taste-partitions = 5;

  # The amount of queries that can be executed in parallel.
  max-queries = 10;

  # The directory to use for the partition synopses of the catalog.
  #catalog-dir= <dbdir>/index

  # The false positive rate for lossy structures in the catalog.
  catalog-fp-rate = 0.01;

  # The store backend to use. Can be either 'archive', 'segment-store', or
  # the name of a user-provided store plugin.
  store-backend = "segment-store";

  # The maximum number of segments cached by the archive.
  segments = 10;

  # The maximum size per segment, in MiB.
  max-segment-size = 1024;

  # Interval between two aging cycles.
  aging-frequency = "24h";

  # Query for aging out obsolete data.
  aging-query = "";

  # Keep track of performance metrics.
  enable-metrics = false;
}
