{
  inputs,
  cell,
}: let
  inherit (inputs) zeek2nix nixpkgs-hardenedlinux;
in {
  inherit
    (zeek2nix.packages)
    btest
    zeek-release
    zeek-latest
    ;
  inherit
    (nixpkgs-hardenedlinux.packages)
    zeekscript
    ;
}
