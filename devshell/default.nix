{
  devshell,
  nixpkgs,
  cells,
  std,
}:
devshell.legacyPackages.mkShell {
  name = "DevSecOps Cells";
  imports = [
    std.std.devshellProfiles.default

    cells.update.devshellProfiles.default

    cells.makeConfiguration.devshellProfiles.default
    # cells.cliche.devshellProfiles.default
    # cells.comonicon.devshellProfiles.default

    # cells.continuous-integration.devshellProfiles.default
    cells.hashicorp.devshellProfiles.default
    # cells.secrets.devshellProfiles.default

    # cells.zeek.devshellProfiles.default
    cells.soc-action.devshellProfiles.default
  ];
  commands = [];
  packages = [
    nixpkgs.treefmt
    nixpkgs.shfmt
    nixpkgs.nodePackages.prettier
    nixpkgs.nodePackages.prettier-plugin-toml
    nixpkgs.python3Packages.black
  ];
  devshell.startup.nodejs-setuphook = nixpkgs.lib.stringsWithDeps.noDepEntry ''
    export NODE_PATH=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
  '';
}
