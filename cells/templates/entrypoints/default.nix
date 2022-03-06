{
  inputs,
  cell,
}: let
  inherit (cell) packages library;
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._templates.library) makeTemplate;
in {
  threatbus-nomad-nixpkgs-nickel = makeTemplate {
    name = "nomad-threatbus";
    target = "nomad";
    language = "nickel";
    format = "json";
    args = ["threatbus-nomad-nix.ncl"];
    path = ./tenzir/nomad;
  };

  threatbus-nomad-nixpkgs-cue = makeTemplate {
    name = "cue-threatbus";
    language = "cue";
    target = "nomad";
    format = "yaml";
    args = ["jobs.dev"];
    path = ./tenzir/nomad;
  };
  threatbus-terranix-nixpkgs-terranix = makeTemplate {
    name = "terranix-threatbus";
    target = "terranix";
    # terranix
    language = "nix";
    args = ["config.nix"];
    path = ./tenzir/nomad;
  };
}
