{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std self;
  inherit (nixpkgs) lib;
  __inputs__ =
    (std.deSystemize nixpkgs.system
      (import "${(std.incl self [(self + /lock)])}/lock").inputs)
    // inputs;
in {
  inherit __inputs__;
  /*
  tests = mergeDevShell { default = cell.devshellProfiles.mkshell; mkshell = cell.devshell;};
  */
  mergeDevShell = import ./mergeDevShell.nix nixpkgs;
}
