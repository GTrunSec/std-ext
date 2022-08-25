{
  inputs,
  cell,
} @ args: let
  lib =
    (inputs.nixpkgs.appendOverlays [
      (_final: prev: {
        lib = prev.lib.extend (import ../../_lib/extend.nix {inherit inputs;});
      })
    ])
    .lib;
in
  {
  }
  // (lib.makeNestedJobs [
      ./nomad
    ]
    args)
