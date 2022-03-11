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
        package = packages.nickel;
        category = "nickel";
        help = "Better configuration for less";
      }
    ];
  };
}
