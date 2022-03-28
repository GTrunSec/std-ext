{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile makeConfiguration;
  inherit (inputs.cells._writers.library) writeShellApplication;
in {
  nomad-container = makeConfiguration {
    name = "misp-nomad-container-dev";
    target = "nomad";
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
