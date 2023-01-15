{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells.writers.lib) writeShellApplication;
  inherit (cell) packages;
in {
  # podman-cliche-example = writeShellApplication {
  #   name = "cliche-example";
  #   runtimeInputs = [nixpkgs.podman];
  #   text = ''
  #     ${packages.cliche-example.copyToPodman}/bin/copy-to-podman
  #     podman run ${packages.cliche-example.imageName}:${packages.cliche-example.imageTag} example add 2 3
  #   '';
  # };

  # podman-comonicon-mycmd = writeShellApplication {
  #   name = "comonicon-mycmd";
  #   runtimeInputs = [nixpkgs.podman];
  #   text = ''
  #     ${packages.comonicon-mycmd.copyToPodman}/bin/copy-to-podman
  #     podman run ${packages.comonicon-mycmd.imageName}:${packages.comonicon-mycmd.imageTag} mycmd
  #   '';
  # };
  cliche-example-prod = (import ./cliche-example args).prod;
}
