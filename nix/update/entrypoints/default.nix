{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    __inputs__.nixpkgs-hardenedlinux.overlays."nixpkgs/nixpkgs-hardenedlinux-sources"
  ];
  inherit (cell) packages;
  inherit (inputs.cells._writers.library) writeShellApplication;
in {
  nix-github-update = writeShellApplication {
    name = "nix-github-update";
    runtimeInputs = [packages.nvfetcher nixpkgs.coreutils];
    text =
      "export nixVersion=${toString nixpkgs.nixpkgs-hardenedlinux-sources.nix-unstable-installer.src.urls} \n"
      + nixpkgs.lib.fileContents ./nix-github-update.bash;
  };
  nvfetcher-update = writeShellApplication {
    name = "nvfetcher-update";
    runtimeInputs = [packages.nvfetcher];
    text = "export NIX_PATH=nixpkgs=${nixpkgs.path} \n" + nixpkgs.lib.fileContents ./nvfetcher-update.bash;
  };
}
