{
  inputs,
  cell,
}: let
  inherit (cell) packages library;
  inherit (inputs) nixpkgs inputsSystem terranix;
in {
  nickel = library.importNcl ./shell.ncl inputsSystem;
  default = _: {
    commands = [
      {
        package = packages.nickel;
        category = "Configuration";
        help = "Better configuration for less";
      }
      {
        package = nixpkgs.cue;
        category = "Configuration";
        help = "Validate, define, and use dynamic and text-based data";
      }
    ];
  };
}
