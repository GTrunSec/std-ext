{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) packages;
in {
  default = _: {
    commands = [
      {
        package = packages.deadnix;
        category = "nix-linter";
      }
      {
        package = packages.statix;
        category = "nix-linter";
      }
    ];
  };
}
