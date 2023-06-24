{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
  inherit (std) lib;
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
        (lib.dev.mkNixago cell.configs.treefmt)
        (lib.dev.mkNixago cell.configs.conform)
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
