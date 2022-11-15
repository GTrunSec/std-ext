{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    (_final: _prev: {
      cliche = nixpkgs.python3Packages.callPackage ./cliche {};
    })
  ];
in {
  inherit (nixpkgs) cliche;
}
