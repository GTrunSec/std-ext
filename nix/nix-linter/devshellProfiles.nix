{
  inputs,
  cell,
}: let
  inherit (cell) packages;
in {
  default = _: {
    commands = [
      {
        package = packages.deadnix;
        category = "nix-linter";
        help = "Scan Nix files for dead code";
      }
      {
        package = packages.statix;
        category = "nix-linter";
      }
    ];
  };
}
