{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in rec {
  /*
   tests = mergeDevShell { default = cell.devshellProfiles.mkshell; mkshell = cell.devshell;};
   */
  mergeDevShell = import ./mergeDevShell.nix nixpkgs;
}
