{
  devshell,
  nixpkgs,
  cells,
}:
devshell.legacyPackages.mkShell {
  name = "github SOC Action Shell";
  imports = [
    cells.soc-action.devshellProfiles.default
  ];
}
