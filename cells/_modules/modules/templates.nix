{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.templates;
in {
  options.templates = with lib; {
    name = mkOption {
      type = types.str;
      default = "templates";
      description = ''
        Name of the templates
      '';
    };
    text = mkOption {
      type = types.str;
      default = "echo Template";
      description = ''
        write your shell context here
      '';
    };
    language = mkOption {
      type = types.enum ["nickel" "nix" "cue"];
      default = "nickel";
      description = ''
        Write your shell context here
      '';
    };
    target = mkOption {
      type = types.enum ["nomad" "terraform" "podman" "docker" "k8s"];
      default = "echo Template";
      description = ''
        Which platform do you want to deploy it by template
      '';
    };
    path = mkOption {
      type = types.path;
      default = [];
      description = ''
        The path for Your Configuration files
      '';
    };
    format = mkOption {
      type = types.enum ["yaml" "toml" "json" "json"];
      default = [];
      description = ''
        Which format do you want to generate in.
      '';
    };
    branch = mkOption {
      type = types.enum ["prod" "dev" "backport" "staging" "CI"];
      default = [];
      description = ''
        Which branch do you want to import in.
      '';
    };
    features = mkOption {
      description = "The feature list which can we support";
      default = [];
      type = with types;
        listOf (submodule {
          options = {
            zeek = mkEnableOption "add zeek support";
            openCTI = mkEnableOption "add zeek support";
            suricata = mkEnableOption "add suricata";
          };
        });
    };
    searchPaths = mkOption {
      type = types.attrs;
      default = {};
    };
    runtimeInputs = mkOption {
      type = types.listOf types.str;
      default = [];
    };

    args = mkOption {
      type = types.listOf types.str;
      default = [];
    };
    makeConfiguration = mkOption {
      type = types.package;
    };
    makeSocProfile = mkOption {
      type = types.package;
    };
  };

  imports = [./makeConfiguration.nix ./makeSocProfile.nix];
}
