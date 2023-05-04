{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std flops;

  callInputs =
    (flops.lib.flake.pops.default.setInitInputs (flops.lib.callFlake ./lock))
    .setSystem
    nixpkgs.system;
in {
  inherit callInputs;
  __inputs__ = callInputs.outputsForInputsCompat;

  mergeDevShell = import ./mergeDevShell.nix nixpkgs;
}
