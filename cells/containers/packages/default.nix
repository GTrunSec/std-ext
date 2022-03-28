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
  opencti-platform = nixpkgs.callPackage ./images/opencti-platform.nix {};
  cliche-example = nixpkgs.callPackage ./images/cliche-example.nix {inherit inputs cell;};
}
