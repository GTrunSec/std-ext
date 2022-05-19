{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
  withCategory = category: attrset: attrset // {inherit category;};
in
  l.mapAttrs (_: std.std.lib.mkShell) {
    default = {
      extraModulesPath,
      pkgs,
      ...
    }: {
      name = "DevSecOps Cells Lab";

      std.docs.enable = false;
      std.adr.enable = false;

      git.hooks = {
        enable = true;
        # pre-commit.text = builtins.readFile ./pre-flight-check.sh;
      };
      imports = [
        std.std.devshellProfiles.default
        "${extraModulesPath}/git/hooks.nix"
        inputs.cells.cargo-make.devshellProfiles.default
      ];
      commands = [
        (withCategory "hexagon" {package = nixpkgs.treefmt;})
        # (withCategory "hexagon" {package = nixpkgs.colmena;})
      ];
      packages = with nixpkgs; [
        # formatters
        alejandra
        nodePackages.prettier
        nodePackages.prettier-plugin-toml
        shfmt
        dasel
      ];
      devshell.startup.nodejs-setuphook =
        l.stringsWithDeps.noDepEntry
        ''
          export NODE_PATH=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
        '';
    };
  }
  // {
    update = {...}: {imports = [inputs.cells.update.devshellProfiles.default];};
  }
