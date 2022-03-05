{
  inputs,
  cell,
}: let
  inherit (cell) packages library devshellProfiles;
  inherit (inputs) nixpkgs zeek2nix;
in {
  zeek-release = zeek2nix.packages.zeek-release;
  btest = zeek2nix.packages.btest;
}
