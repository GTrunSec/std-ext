{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs std self;
  inherit (nixpkgs) lib;
  __inputs__ = cell.library.callFlake "${(std.incl self [(self + /lock)])}/lock" {
    # this is a hack to get the lock file to be followed in our nixpkgs channel
    nodes.nixpkgs.locked = inputs.nixpkgs-lock.sourceInfo;
    nodes.statix.inputs.nixpkgs = "nixpkgs";
    nodes.nixpkgs-hardenedlinux.inputs.nixpkgs = "nixpkgs";
  };
in {
  inherit __inputs__;
  /*
  tests = mergeDevShell { default = cell.devshellProfiles.mkshell; mkshell = cell.devshell;};
  */
  mergeDevShell = import ./mergeDevShell.nix nixpkgs;

  callFlake = import ./callFlake.nix args;
}
