{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (__inputs__) std;
in
{
  dev = std.lib.ops.mkMicrovm {
    nixpkgs.overlays = [
      __inputs__.nomad-driver.overlay
      (import ../packages/nomad.nix)
    ];
    disabledModules = [ "services/networking/nomad.nix" ];
    imports = [
      cell.nixosProfiles.nomad
      cell.nixosProfiles.nomad-module
      ./dev.nix
      ./microvm.nix
    ];
    _module.args = {
      inherit (cell) packages;
    };
  };
}
