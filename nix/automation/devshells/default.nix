{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "Std Extensions";
      imports =
        [
          cell.devshellProfiles.default
          cell.devshellProfiles.docs
          inputs.cells.workflows.devshellProfiles.default
        ]
        ++ [
          inputs.cells.hashicorp.devshellProfiles.default
        ];
      nixago = [
        cell.nixago.treefmt
      ];
      # ++ __attrValues inputs.cells.preset.nixago;
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
