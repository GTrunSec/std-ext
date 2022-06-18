{
  inputs,
  cell,
}: let
  inherit (inputs.cells._microvms.library) makeVM;
in {
  dev = makeVM {
    channel = inputs.nixos.legacyPackages;
    module = _: {
      nixpkgs.overlays = [inputs.nomad-driver.overlay];
      disabledModules = ["services/networking/nomad.nix"];
      imports = [
        cell.nixosProfiles.nomad
        cell.nixosProfiles.nomad-module
        ./dev.nix
      ];
      _module.args = {
        inherit (cell) packages;
      };
    };
  };
}
