{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs generator library;
  inherit (inputs.cells._modules.library) makeSocProfile;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells._templates.library) attrConvertTemplate;
  inherit (inputs.cells.makes.library) __output__ makeSubstitution;

  vast-config-state-1 = data-merge.merge generator.prod {
    vast.endpoint = "192.168.1.1:4000";
  };
in {
  vast-nomad-default = attrConvertTemplate {
    name = "vast-nomad-default";
    source = nomadJobs.default;
    # the attrConvertTemplate does not work with hcl to nomad
    format = "json";
  };

  socProfile-openCTI-solution = makeSocProfile {
    features = {
      # TIPs
      openCTI = true;
      zeek = true;
    };
    target = "k8s"; # or k8s, podman, docker;
    format = "yaml";
    # source = makeSocProfile-custom1;
    path = "/tmp/OpenCTI-HELM-CHART/templates";
  };
  vast-config-prod = attrConvertTemplate {
    name = "vast-config-prod";
    source = vast-config-state-1;
    format = "yaml";
  };
}
