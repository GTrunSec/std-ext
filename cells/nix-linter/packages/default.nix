{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.deadnix.overlay
    inputs.statix.overlay
  ];
in {
  inherit (nixpkgs) statix deadnix;
}
