{
  cell,
  inputs,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (__inputs__) terranix nixpkgs;
  inherit (inputs.nixpkgs) system;
  inherit (inputs.cells._writers.lib) writeConfiguration;
in {
  example = terranix.lib.terranixConfiguration {
    inherit system;
    modules = [./example.nix];
  };
}
