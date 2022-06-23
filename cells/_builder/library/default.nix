{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.nixpkgs) lib;
in {
  mkPaths = import ./mkPaths.nix {inherit nixpkgs lib;};
}
