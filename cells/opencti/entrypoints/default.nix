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
    name = "opencti-nomad-container-dev";
    target = "nomad";
    source = nomadJobs.container {
      driver = "podman";
    };
    format = "json";
  };
  nomad-hydration = makeTemplate {
    name = "opencti-nomad-hydration-dev";
    target = "nomad";
    source = nomadJobs.opencti-compose {
      driver = "podman";
    };
    format = "json";
  };
}
