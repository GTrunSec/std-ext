{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self nomad spongix nomad-driver-nix;
  inherit (inputs.nixpkgs.lib.strings) fileContents;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (cell) packages;
in {
  podman-alpine = writeShellApplication {
    name = "podman-alpine";
    runtimeInputs = [nixpkgs.podman];
    text = ''
      ${packages.images-alpine.copyToPodman}/bin/copy-to-podman
      # podman run ${packages.images-alpine.imageName}:${packages.alpine-images.imageTag} | grep /etc/alpine-release
      # podman rmi docker.io/library/${packages.images-alpine.imageName}:${packages.images-alpine.imageTag}
    '';
  };
}
