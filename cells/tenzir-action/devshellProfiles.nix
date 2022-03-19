{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
in {
  default = _: {
    imports = [inputs.cells.tenzir.devshellProfiles.default];
    commands = [];
  };
}
