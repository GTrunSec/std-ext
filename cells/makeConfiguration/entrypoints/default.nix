{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs inputs';
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
  threatbus-terranix-nixpkgs-terranix = makeConfiguration {
    name = "terranix-threatbus";
    target = "terranix";
    # terranix
    language = "nix";
    args = ["config.nix"];
    path = ./tenzir/nomad;
  };
  nickel-test = (library.importNcl ./shell.ncl) inputs';
}
