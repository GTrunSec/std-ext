{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs zeek2nix;
in {
  inherit
    (zeek2nix.packages)
    btest
    zeek-release
    zeek-latest
    ;
}
