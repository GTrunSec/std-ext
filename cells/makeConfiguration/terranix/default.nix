{
  cell,
  inputs,
}: let
  inherit (inputs.cells.main.library) __inputs__;
  inherit (__inputs__) terranix nixpkgs;
  inherit (inputs.nixpkgs) system;
  inherit (inputs.cells._writers.library) writeConfiguration;
in {
  example = terranix.lib.terranixConfiguration {
    inherit system;
    modules = [./example.nix];
  };
}
