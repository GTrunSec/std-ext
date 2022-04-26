{
  inputs,
  cell,
}: let
  inherit (inputs.cells._modules.library) makeConfiguration;
in {
  makeNomadJobs = name: branch: source:
    makeConfiguration {
      inherit name branch source;
      target = "nomad";
      format = "json";
    };
}
