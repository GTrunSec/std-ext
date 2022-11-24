{
  inputs,
  cell,
}: {
  extraModulesPath,
  pkgs,
  lib,
  ...
}: let
  withCategory = category: attrset: attrset // {inherit category;};
in {
  imports = [
    inputs.std.std.devshellProfiles.default
    "${extraModulesPath}/git/hooks.nix"
  ];
}
