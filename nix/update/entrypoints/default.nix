{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.lib) __inputs__;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    __inputs__.nixpkgs-hardenedlinux.pkgs.overlays.default
  ];
  inherit (cell) packages;
  inherit (inputs.cells._writers.lib) writeShellApplication;
in {
  nix-github-update = writeShellApplication {
    name = "nix-github-update";
    runtimeInputs = [packages.nvfetcher nixpkgs.coreutils];
    text =
      "export nixVersion=${toString nixpkgs.nixpkgs-hardenedlinux-pkgs-sources.nix-unstable-installer.src.urls} \n"
      + nixpkgs.lib.fileContents ./nix-github-update.bash;
  };
  nvfetcher-update = writeShellApplication {
    name = "nvfetcher-update";
    runtimeEnv = {
      LC_ALL = "en_US.UTF-8";
    };
    runtimeInputs = [packages.nvfetcher];
    text = "export NIX_PATH=nixpkgs=${nixpkgs.path} \n" + nixpkgs.lib.fileContents ./nvfetcher-update.bash;
  };
}
