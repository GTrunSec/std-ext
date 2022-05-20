{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.std.lib.mkShell) {
    default = {...}: {
      name = "DevSecOps Cells Lab";
      imports = [
        cell.devshellProfiles.main
        inputs.cells.cargo-make.devshellProfiles.default
      ];
    };
    update = {...}: {imports = [inputs.cells.update.devshellProfiles.default];};
  }
