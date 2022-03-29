{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile makeConfiguration;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) __output__ makeSubstitution;

  vast-config-state-1 = data-merge.merge generator.prod {
    vast.endpoint = "192.168.1.1:4000";
  };
in {
  nomad-node-dev = makeConfiguration {
    name = "nomad-node";
    branch = "dev";
    target = "nomad";
    source = nomadJobs.vast-nixos-node {
      flake = "${self.outPath}#${nixpkgs.system}.tenzir.nixosProfiles.nomad-tenzir-vast";
    };
    format = "json";
  };

  nomad-nixos-opencti-dev = makeConfiguration {
    name = "nomad-nixos-opencti-dev";
    target = "nomad";
    source = nomadJobs.vast-nixos-node {
      flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-opencti";
    };
    format = "json";
  };

  socProfile-openCTI-solution = makeSocProfile {
    features = {
      # TIPs
      openCTI = true;
      zeek = true;
    };
    target = "nomad"; # or k8s, podman, docker;
  };

  config-vast-prod = makeConfiguration {
    name = "config-vast";
    target = "regular";
    source = vast-config-state-1;
    format = "yaml";
    branch = "prod";
  };
}
