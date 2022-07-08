{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std self;
  inputs' =
    (std.deSystemize nixpkgs.system
      (import "${(std.incl self [(self + /lock)])}/lock").inputs)
    // inputs;
in {
  inherit inputs';
  /*
   tests = mergeDevShell { default = cell.devshellProfiles.mkshell; mkshell = cell.devshell;};
   */
  mergeDevShell = import ./mergeDevShell.nix nixpkgs;
}
