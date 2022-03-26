{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) library;
  inherit (inputs.cells._modules.library) makeConfiguration;
in {
  threatbus-nomad-nixpkgs-nickel = makeConfiguration {
    name = "nomad-threatbus";
    target = "nomad";
    language = "nickel";
    format = "json";
    args = ["threatbus-nomad-nix.ncl"];
    path = ./tenzir/nomad;
  };

  threatbus-nomad-nixpkgs-cue = makeConfiguration {
    name = "cue-threatbus";
    language = "cue";
    target = "nomad";
    format = "yaml";
    args = ["jobs.dev"];
    path = ./tenzir/nomad;
  };
}
