{
  inputs,
  cell,
}: let
  inherit (cell) lib terranix;
  inherit (inputs.cells.writers.lib) writeConfiguration;
in {
  threatbus-nomad-nixpkgs-nickel = writeConfiguration {
    name = "nomad-threatbus";
    target = "nomad";
    language = "nickel";
    format = "json";
    args = ["threatbus-nomad-nix.ncl"];
    source = ./tenzir/nomad;
  };

  threatbus-nomad-nixpkgs-cue = writeConfiguration {
    name = "cue-threatbus";
    language = "cue";
    target = "nomad";
    format = "yaml";
    args = ["jobs.dev"];
    source = ./tenzir/nomad;
  };

  terraform-example = writeConfiguration {
    name = "terraform-nixos-example";
    language = "nix";
    format = "json";
    target = "terraform";
    source = terranix.example;
  };
}
