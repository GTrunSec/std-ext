{
  inputs,
  cell,
}: let
  inherit (cell) packages;
  inherit (inputs) nixpkgs;
in {
  default = _: {
    commands = [
      {
        name = "just-opencti";
        command = "just -f $PRJ_ROOT/cells/opencti/entrypoints/justfile $@";
        help = "run justfile in the opencti";
        category = "opencti";
      }
    ];
  };
}
