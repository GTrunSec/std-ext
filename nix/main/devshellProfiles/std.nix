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
  std.docs.enable = false;
  std.adr.enable = false;

  imports = [
    inputs.std.std.devshellProfiles.default
    "${extraModulesPath}/git/hooks.nix"
  ];
}
