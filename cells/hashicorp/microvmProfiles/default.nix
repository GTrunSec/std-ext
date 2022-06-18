{
  inputs,
  cell,
}: let
  inherit (inputs.cells._microvms.library) makeVM;
in {
  dev = makeVM {
    channel = inputs.nixos.legacyPackages;
    module = _: {
      imports = [
        cell.nixosProfiles.nomad
        ./dev.nix
      ];
      _module.args = {
        inherit (cell) packages;
      };
    };
  };
}
