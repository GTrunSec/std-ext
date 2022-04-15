{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) nomadJobs;
  inherit (inputs.cells._modules.library) makeConfiguration;

  name = builtins.baseNameOf ./.;

  common = branch:
    makeConfiguration {
      inherit name;
      target = "nomad";
      source =
        nixpkgs.lib.recursiveUpdate (nomadJobs.container.elasticsearch {
          driver = "podman";
        }) {
          job.elasticsearch = (nomadJobs.container.kibana {driver = "podman";}).job.elasticsearch;
        };
      inherit branch;
      format = "json";
    };
in {
  dev = common "dev";
  prod = common "prod";
}
