{
  inputs,
  cell,
}: let
  inherit (inputs.cells.microvms.library) makeVM;
  inherit (inputs.cells.main.library) __inputs__;
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
