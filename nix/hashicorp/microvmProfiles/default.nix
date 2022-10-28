{
  inputs,
  cell,
}: let
  inherit (inputs.cells.microvms.lib) makeVM;
  inherit (inputs.cells.common.lib) __inputs__;
in {
  dev = makeVM {
    channel = inputs.nixos.legacyPackages;
    module = _: {
      nixpkgs.overlays = [
        __inputs__.nomad-driver.overlay
        (import ../packages/nomad.nix)
      ];
      disabledModules = ["services/networking/nomad.nix"];
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
  };
}
