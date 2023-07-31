{ inputs, cell }:
let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
l.mapAttrs (_: std.lib.dev.mkShell) {
  default =
    { ... }:
    {
      std.adr.enable = false;

      name = "default: Cells Lab Tempalte";

      imports = [ inputs.std-ext.automation.devshellProfiles.default ];

      nixago = [
        cell.nixago.mdbook
        cell.nixago.treefmt
      ];
    };
}
