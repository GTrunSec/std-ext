{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    (
      final: prev: {
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
  images-alpine = nixpkgs.callPackage ./images/alpine.nix {};
}
