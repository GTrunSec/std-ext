{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std flops;

  callInputs =
    (flops.lib.flake.pops.default.setInitInputs ./lock)
    .setSystem
    nixpkgs.system;
in {
  inherit callInputs;
  __inputs__ =
    (callInputs.addInputsOverride {
      # nixpkgs = callInputs.sysInputs.nixpkgs;
    })
    .outputsForInputsCompat;

  mergeDevShell = import ./mergeDevShell.nix nixpkgs;
}
