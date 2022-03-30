{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (cell) packages;
in {
  opencti-platform-podman = writeShellApplication {
    name = "alpine-podman";
    runtimeInputs = [nixpkgs.podman];
    text = ''
      ${packages.opencti-platform.copyToPodman}/bin/copy-to-podman
      podman run ${packages.opencti-platform.imageName}:${packages.opencti-platform.imageTag} | grep /opt/opencti
    '';
  };
  cliche-example-podman = writeShellApplication {
    name = "cliche-example";
    runtimeInputs = [nixpkgs.podman];
    text = ''
      ${packages.cliche-example.copyToPodman}/bin/copy-to-podman
      podman run ${packages.cliche-example.imageName}:${packages.cliche-example.imageTag} example add 2 3
    '';
  };
}
