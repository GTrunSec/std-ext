nixpkgs: {
  configuration,
  lib ? nixpkgs.lib,
  extraSpecialArgs ? {},
}: let
  socCellsModules = import ./modules.nix {
    pkgs = nixpkgs;
    inherit lib;
  };

  module = lib.evalModules {
    modules =
      [
        configuration
      ]
      ++ socCellsModules;
    specialArgs =
      {modulesPath = builtins.toString ./.;}
      // extraSpecialArgs;
  };
in {
  inherit (module) config;

  shell = module.config.devshell.shell;
}
