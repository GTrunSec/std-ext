{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    __inputs__.deadnix.overlays.default
    __inputs__.statix.overlay
  ];
in {
  inherit (nixpkgs) statix deadnix;
}
