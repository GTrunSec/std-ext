{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells._templates.library) attrConvertTemplate;
in {
  opencti-nomad-container = attrConvertTemplate {
    name = "opencti-nomad-container";
    target = "nomad";
    source = nomadJobs.opencti-compose {
      driver = "podman";
    };
    format = "json";
  };
  opencti-nomad-hydration = attrConvertTemplate {
    name = "opencti-nomad-hydration";
    target = "nomad";
    source = nomadJobs.opencti-compose {
      driver = "podman";
    };
    format = "json";
  };
}
