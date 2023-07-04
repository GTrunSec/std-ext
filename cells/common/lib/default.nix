{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std flops;
  inherit (flops.inputs) POP;
  callInputs =
    (flops.lib.flake.pops.default.setInitInputs ./lock)
    .setSystem
    nixpkgs.system;
in {
  inherit callInputs;
  __inputs__ =
    (callInputs.addInputsOverrideExtender (POP.lib.extendPop flops.lib.flake.pops.inputsExtender (self: super: {
      # nixpkgs = callInputs.sysInputs.nixpkgs;
    })))
    .outputsForInputs;

  mergeDevShell = import ./mergeDevShell.nix nixpkgs;
}
