{
  inputs,
  cell,
}: let
  inherit (cell) library;
  inherit (inputs.cells._writers.library) writeConfigurationFromLang;
in {
  threatbus-nomad-nixpkgs-nickel = writeConfigurationFromLang {
    name = "nomad-threatbus";
    target = "nomad";
    language = "nickel";
    format = "json";
    args = ["threatbus-nomad-nix.ncl"];
    source = ./tenzir/nomad;
  };

  threatbus-nomad-nixpkgs-cue = writeConfigurationFromLang {
    name = "cue-threatbus";
    language = "cue";
    target = "nomad";
    format = "yaml";
    args = ["jobs.dev"];
    source = ./tenzir/nomad;
  };
}
