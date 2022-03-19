{
  devshell,
  nixpkgs,
  cells,
}:
devshell.legacyPackages.mkShell {
  name = "Cells: Zeek Action Shell";
  imports = [
    cells.zeek-action.devshellProfiles.default
  ];
}
