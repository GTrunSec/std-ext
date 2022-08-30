{
  inputs,
  cell,
}@args: let
  inherit (inputs) nixpkgs std self;
  inherit (nixpkgs) lib;
  __inputs__ = cell.library.callFlake "${(std.incl self [(self + /lock)])}/lock" {
    statix.inputs.nixpkgs = inputs.nixpkgs.__inputs__.nixos;
  };
in {
  inherit __inputs__;
  /*
  tests = mergeDevShell { default = cell.devshellProfiles.mkshell; mkshell = cell.devshell;};
  */
  mergeDevShell = import ./mergeDevShell.nix nixpkgs;

  callFlake = import ./callFlake.nix args;
}
