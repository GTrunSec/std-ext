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
    cells.comonicon.devshellProfiles.default

    # cells.continuous-integration.devshellProfiles.default
    cells.hashicorp.devshellProfiles.default
    cells.secrets.devshellProfiles.default

    cells.containers.devshellProfiles.default

    # cells.zeek.devshellProfiles.default
    cells.soc-action.devshellProfiles.default
  ];
  commands = [
    {
      name = "eval-cells";
      command = "nix-eval-jobs --gc-roots-dir $(pwd)/gcroot --flake $PRJ_ROOT/#packages.${nixpkgs.system}";
      help = "eval cells jobs by nix-eval-jobs";
    }
  ];
  packages = [
    nixpkgs.treefmt
    nixpkgs.shfmt
    nixpkgs.nodePackages.prettier
    nixpkgs.nodePackages.prettier-plugin-toml
    nixpkgs.python3Packages.black
    nixpkgs.nix-eval-jobs
    nixpkgs.just
  ];
  devshell.startup.nodejs-setuphook = nixpkgs.lib.stringsWithDeps.noDepEntry ''
    export NODE_PATH=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
  '';
}
