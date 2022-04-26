{
  inputs,
  cell,
}: let
  lib =
    (inputs.nixpkgs.appendOverlays [
      (_final: prev: {
        lib = prev.lib.extend (import ./extend.nix {inherit inputs;});
      })
    ])
    .lib;
in {
  inherit lib;
}
