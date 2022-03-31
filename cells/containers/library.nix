{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    (
      _final: _prev: {
        inherit
          (inputs.nix2container.packages)
          nix2containerUtil
          skopeo-nix2container
          nix2container
          ;
      }
    )
  ];
in {
  inherit nixpkgs;
}
