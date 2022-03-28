{
  pkgs,
  lib,
}: let
  modules = [
    ./template-options.nix
    ./socProfile-options.nix
  ];

  pkgsModule = {config, ...}: {
    config = {
      _module.args.baseModules = modules;
      _module.args.pkgsPath = lib.mkDefault pkgs.path;
      _module.args.pkgs = lib.mkDefault pkgs;
    };
  };
in
  [pkgsModule] ++ modules
