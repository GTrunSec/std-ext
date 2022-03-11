nixpkgs: {
  configuration,
  lib ? nixpkgs.lib,
  extraSpecialArgs ? {},
}: let
  devSecOpsModules = import ./modules.nix {
    pkgs = nixpkgs;
    inherit lib;
  };

  module = lib.evalModules {
    modules =
      [
        configuration
      ]
      ++ devSecOpsModules;
    specialArgs =
      {modulesPath = builtins.toString ./.;}
      // extraSpecialArgs;
  };
in {
  inherit (module) config;
}
