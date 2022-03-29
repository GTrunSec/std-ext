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
        name = "just-profiles";
        command = "just -f $PRJ_ROOT/cells/profiles/entrypoints/justfile $@";
        help = "run justfile in the profiles";
        category = "opencti";
      }
    ];
  };
}
