{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) containerJobs;
  inherit (inputs.cells._writers.library) writeShellApplication;

  name = "tenzir-" + builtins.baseNameOf ./.;

  common = version: let
    package = (containerJobs.vast.nix version)."${version}";
  in
    writeShellApplication {
      inherit name;
      runtimeInputs = [nixpkgs.podman];
      text = ''
        ${package.copyToPodman}/bin/copy-to-podman
        podman run ${package.imageName}:${package.imageTag}
      '';
    };
in {
  release.prod = common "release";
  latest.prod = common "latest";
}
