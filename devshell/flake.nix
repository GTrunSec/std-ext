{
  description = "DevSecOps Cells Development Shells";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.follows = "cells/nixpkgs";
  inputs.std.follows = "cells/std";
  inputs.cells.url = "../.";

  outputs = inputs:
    inputs.flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin"] (
      system: let
        inherit
          (inputs.cells.inputs.std.deSystemize system inputs)
          cells
          devshell
          std
          ;
        nixpkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        devShells.default = import ./. {inherit devshell nixpkgs cells std;};
        devShells.github-soc-action = import ./github-soc-action.nix {inherit devshell nixpkgs cells;};
        devShells.zeek-action = import ./zeek-action.nix {inherit devshell nixpkgs cells;};
        devShells.tenzir-action = import ./tenzir-action.nix {inherit devshell nixpkgs cells;};
        devShells.withNickel = cells.makeConfiguration.devshellProfiles.nickel;
        devShells.update = import ./update.nix {inherit devshell nixpkgs cells;};
      }
    );
}
