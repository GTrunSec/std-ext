{
  inputs,
  cell,
}: let
  inherit (inputs) std nixpkgs data-merge;
in {
  treefmt = std.std.nixago.treefmt {
    configData.formatter.nix = {
      excludes = [
        "generated.nix"
      ];
    };
  };
}
