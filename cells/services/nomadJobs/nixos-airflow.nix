{
  flake ? "",
  datacenters ? [ "dc1" ],
  type ? "batch",
  namespace ? "default",
}:
let
  resources = {
    memory = 1100;
    cpu = 3000;
  };
in
{
  job.airflow = {
    inherit datacenters type namespace;
    group.nixos = {
      count = 1;

      task.airflow = {
        driver = "nix";

        inherit resources;

        config = {
          nixos = flake;
        };
      };
    };
  };
}
