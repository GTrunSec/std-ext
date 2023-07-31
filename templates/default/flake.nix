{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    std-ext.url = "github:GTrunSec/std-ext";

    std.follows = "std-ext/std";
  };
  outputs =
    { std, ... }@inputs:
    std.growOn
      {
        inherit inputs;
        cellsFrom = ./nix;

        cellBlocks = [
          (std.blockTypes.installables "packages")

          (std.blockTypes.functions "devshellProfiles")
          (std.blockTypes.devshells "devshells")

          (std.blockTypes.runnables "entrypoints")

          (std.blockTypes.functions "lib")

          (std.blockTypes.functions "packages")

          (std.blockTypes.functions "overlays")

          (std.blockTypes.nixago "nixago")
        ];
      }
      {
        devShells = inputs.std.harvest inputs.self [
          "main"
          "devshells"
        ];
      };
}
