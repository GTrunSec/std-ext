{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "Cells Lab";
      imports =
        [
          cell.devshellProfiles.default
          cell.devshellProfiles.docs
          inputs.cells.cargoMake.devshellProfiles.default
        ]
        ++ [
          inputs.cells.hashicorp.devshellProfiles.default
          inputs.cells.makeConfiguration.devshellProfiles.default
        ];
      nixago = [
        cell.nixago.treefmt
      ];
    };

    update = {...}: {imports = [inputs.cells.update.devshellProfiles.default];};

    docs = {
      name = "mkdocs";

      std.adr.enable = false;

      imports = [
        inputs.std.std.devshellProfiles.default
      ];
      nixago = [
        cell.nixago.mdbook
      ];
    };
  }
