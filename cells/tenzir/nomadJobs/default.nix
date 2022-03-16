{
  inputs,
  cell,
}: {
  default = {
    command = "echo hello";
    interval = "30s";
    timeout = "10s";
    type = "script";
  };
}
