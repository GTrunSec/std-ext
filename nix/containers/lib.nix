{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.lib) writeShellApplication;
  inherit (inputs.cells._modules.lib) makeConfiguration;
  inherit (inputs.cells.main.lib) __inputs__;

  nixpkgs = inputs.nixpkgs.appendOverlays [
    (
      _final: _prev: {
        inherit
          (__inputs__.nix2container.packages)
          nix2containerUtil
          skopeo-nix2container
          nix2container
          ;
      }
    )
  ];
in {
  inherit nixpkgs;

  makePodmanJobs = package:
    writeShellApplication {
      name = "makePodmanJobs";
      runtimeInputs = [nixpkgs.podman];
      text = ''
        ${package.copyToPodman}/bin/copy-to-podman
        podman run ${package.imageName}:${package.imageTag}
      '';
    };

  makeDockerComposeJobs = branch: source:
    makeConfiguration {
      name = "makeDockerComposeJobs";
      inherit branch source;
      target = "docker-compose";
      format = "yaml";
    };
}
