{
  inputs,
  cell,
}: let
  lib =
    (inputs.nixpkgs.appendOverlays [
      (final: prev: {
        lib = prev.lib.extend (import ./extend.nix);
      })
    ])
    .lib;
in {
  inherit lib;
}
