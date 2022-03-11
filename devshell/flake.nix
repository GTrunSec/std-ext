{
  description = "DevSecOps Cells development shell";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";
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
        devShells.github-soc-action = import ./github-soc-action.nix {inherit devshell nixpkgs cells;};
        devShells.default = import ./. {inherit devshell nixpkgs cells std;};
      }
    );
}
