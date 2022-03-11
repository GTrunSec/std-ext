{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
in {
  default = _: {
    imports = [
      inputs.cells.zeek-action.devshellProfiles.default
      inputs.cells.tenzir-action.devshellProfiles.default
    ];
    commands = [];
  };
}
