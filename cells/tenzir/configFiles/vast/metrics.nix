{db-directory, ...}: {
  metrics = {
    self-sink = {
      enable = true;
      slice-size = 128;
      slice-type = "arrow";
    };
    file-sink = {
      enable = false;
      real-time = false;
      path = "${db-directory}/vast-metrics.log";
    };
    # Configures if and where metrics should be written to a socket.
    uds-sink = {
      enable = false;
      real-time = false;
      path = "${db-directory}/vast-metrics.sock";
      type = "datagram";
    };
  };
}
