{
  devshell,
  nixpkgs,
  cells,
}:
devshell.legacyPackages.mkShell {
  name = "Cells: Tenzir Action Shell";
  imports = [
    cells.tenzir-action.devshellProfiles.default
  ];
}
