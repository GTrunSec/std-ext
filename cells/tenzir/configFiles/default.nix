{
  inputs,
  cell,
}: {
  vast = {
    endpoint = "localhost:42000";
    # The file system path used for persistent state.
    #db-directory = "vast.db";

    # The file system path used for log files.
    #log-file = "/server.log";
  };
}
