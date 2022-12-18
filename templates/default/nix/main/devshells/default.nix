{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.std.lib.mkShell) {
    default = {...}: {
      std.adr.enable = false;

      name = "default: Cells Lab Tempalte";

      imports = [
        inputs.cells-lab.automation.devshellProfiles.default
      ];

      nixago = [
        cell.nixago.mdbook
        cell.nixago.treefmt
      ];
    };
  }
