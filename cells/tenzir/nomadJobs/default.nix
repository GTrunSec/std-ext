{
  inputs,
  cell,
}: {
  default = {flake ? ""}: {
    job.vast = {
      datacenters = ["dc1"];
      type = "batch";
      namespace = "tenzir";
      group.nixos = {
        task.vast = {
          driver = "nix";
          resources = {
            memory = 1000;
            cpu = 3000;
          };
          config = {
            nixos = flake;
          };
        };
      };
    };
  };
}
