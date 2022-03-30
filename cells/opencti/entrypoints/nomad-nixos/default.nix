{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs.cells._modules.library) makeConfiguration;

  name = "opencti-nomad-container";

  common = branch:
    makeConfiguration {
      inherit name;
      target = "nomad";
      inherit branch;
      source = nomadJobs.container {
        driver = "podman";
      };
      format = "json";
    };
in {
  dev = common "dev";
}
