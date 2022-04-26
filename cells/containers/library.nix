{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.library) writeShellApplication;

  nixpkgs = inputs.nixpkgs.appendOverlays [
    (
      _final: _prev: {
        inherit
          (inputs.nix2container.packages)
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
}
