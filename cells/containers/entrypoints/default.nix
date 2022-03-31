{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (cell) packages;
in {
  podman-opencti-platform = writeShellApplication {
    name = "alpine-podman";
    runtimeInputs = [nixpkgs.podman];
    text = ''
      ${packages.opencti-platform.copyToPodman}/bin/copy-to-podman
      podman run ${packages.opencti-platform.imageName}:${packages.opencti-platform.imageTag} | grep /opt/opencti
    '';
  };

  podman-cliche-example = writeShellApplication {
    name = "cliche-example";
    runtimeInputs = [nixpkgs.podman];
    text = ''
      ${packages.cliche-example.copyToPodman}/bin/copy-to-podman
      podman run ${packages.cliche-example.imageName}:${packages.cliche-example.imageTag} example add 2 3
    '';
  };
  cliche-example-prod = (import ./cliche-example args).prod;
}
