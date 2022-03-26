{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells._templates.library) makeTemplate;
in {
  nomad-container = makeTemplate {
    name = "misp-nomad-container-dev";
    target = "nomad";
    source = nomadJobs.container {
      driver = "podman";
    };
    format = "json";
  };
  # nomad-hydration = makeTemplate {
  #   name = "misp-nomad-hydration-dev";
  #   target = "nomad";
  #   source = nomadJobs.hydration {
  #     driver = "podman";
  #   };
  #   format = "json";
  # };
}
