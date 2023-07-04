{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    __inputs__.process-compose.overlays.default
  ];
in {
  inherit (nixpkgs) process-compose;
}
