{
  inputs,
  cell,
}: let
  inherit (cell) library;
  inherit (inputs.cells._modules.library) makeConfigurationFromLang;
in {
  threatbus-nomad-nixpkgs-nickel = makeConfigurationFromLang {
    name = "nomad-threatbus";
    target = "nomad";
    language = "nickel";
    format = "json";
    args = ["threatbus-nomad-nix.ncl"];
    path = ./tenzir/nomad;
  };

  threatbus-nomad-nixpkgs-cue = makeConfigurationFromLang {
    name = "cue-threatbus";
    language = "cue";
    target = "nomad";
    format = "yaml";
    args = ["jobs.dev"];
    path = ./tenzir/nomad;
  };
}
