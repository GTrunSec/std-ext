{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    __inputs__.nixpkgs-hardenedlinux.pkgs.overlays.default
  ];
  inherit (inputs.cells.writers.lib) writeShellApplication;
in
{
  nvfetcher-update = writeShellApplication {
    name = "nvfetcher-update";
    runtimeEnv = {
      LC_ALL = "en_US.UTF-8";
    };
    runtimeInputs = [ nixpkgs.nvfetcher ];
    text = nixpkgs.lib.fileContents ./nvfetcher-update.bash;
  };
  nvfetcher-update-force = writeShellApplication {
    name = "nvfetcher-update-force";
    runtimeEnv = {
      LC_ALL = "en_US.UTF-8";
    };
    runtimeInputs = [ nixpkgs.nvfetcher ];
    text = nixpkgs.lib.fileContents ./nvfetcher-update-force.bash;
  };
}
