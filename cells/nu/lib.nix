{ inputs, cell }:
let
  nixpkgs = inputs.nixpkgs.appendOverlays [ cell.overlays.default ];
in
{
  inherit nixpkgs;
}
