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
