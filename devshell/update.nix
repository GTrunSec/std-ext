{
  devshell,
  nixpkgs,
  cells,
}:
devshell.legacyPackages.mkShell {
  name = "Cells: Update Shell";
  imports = [
    cells.update.devshellProfiles.default
  ];
}
