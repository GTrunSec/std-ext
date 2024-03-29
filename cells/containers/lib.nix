{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (inputs.cells.writers.lib) writeShellApplication;

  nixpkgs = inputs.nixpkgs.appendOverlays [
    (_final: _prev: {
      inherit (__inputs__.n2c.packages)
        nix2containerUtil
        skopeo-nix2container
        nix2container
      ;
    })
  ];
in
{
  inherit nixpkgs;

  makePodmanJobs =
    package:
    writeShellApplication {
      name = "makePodmanJobs";
      runtimeInputs = [ nixpkgs.podman ];
      text = ''
        ${package.copyToPodman}/bin/copy-to-podman
        podman run ${package.imageName}:${package.imageTag}
      '';
    };
}
