{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    __inputs__.poetry2nix.overlays.default
    (_final: _prev: {
      cliche = nixpkgs.python3Packages.callPackage ./cliche {};
    })
  ];
in {
  inherit (nixpkgs) cliche;
}
