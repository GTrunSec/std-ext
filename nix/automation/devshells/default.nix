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
          inputs.cells.workflows.devshellProfiles.default
        ]
        ++ [
          inputs.cells.hashicorp.devshellProfiles.default
          inputs.cells.configuration.devshellProfiles.default
        ];
      nixago = [
        cell.nixago.treefmt
      ];
    };

    update = {...}: {imports = [inputs.cells.update.devshellProfiles.default];};

    docs = {
      name = "mkdocs";

      imports = [
        cell.devshellProfiles.docs
      ];

      nixago = [
        cell.nixago.mdbook
      ];
    };
  }
