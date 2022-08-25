{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    __inputs__.deadnix.overlays.default
    __inputs__.statix.overlay
  ];
in {
  inherit (nixpkgs) statix deadnix;
}
