{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs std self;
  inherit (nixpkgs) lib;
  __inputs__ = cell.library.callFlake "${(std.incl self [(self + /lock)])}/lock" {
    # this is a hack to get the lock file to be followed in our nixpkgs channel
    nixpkgs.locked = inputs.nixpkgs-lock.sourceInfo;
    nixos.locked = inputs.nixos.sourceInfo;
    statix.inputs.nixpkgs = "nixpkgs";
    nixpkgs-hardenedlinux.inputs.nixpkgs = "nixpkgs";
    nvfetcher.inputs.nixpkgs = "nixos";
  };
in {
  inherit __inputs__;
  /*
  tests = mergeDevShell { default = cell.devshellProfiles.mkshell; mkshell = cell.devshell;};
  */
  mergeDevShell = import ./mergeDevShell.nix nixpkgs;

  callFlake = import ./callFlake.nix args;
}
