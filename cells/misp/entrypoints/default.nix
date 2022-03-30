{
  inputs,
  cell,
  ...
}: let
  inherit (cell) nomadJobs;
  inherit (inputs.cells._modules.library) makeConfiguration;
in {
  nomad-container = makeConfiguration {
    name = "misp-nomad-container-dev";
    target = "nomad";
    branch = "dev";
    source = nomadJobs.container {
      driver = "podman";
    };
    format = "json";
  };
  # nomad-hydration = makeConfiguration {
  #   name = "misp-nomad-hydration-dev";
  #   target = "nomad";
  #   source = nomadJobs.hydration {
  #     driver = "podman";
  #   };
  #   format = "json";
  # };
}
