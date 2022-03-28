{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.templates;
in {
  options.socProfile = with lib; {
    name = mkOption {
      type = types.str;
      default = "socProfile";
      description = ''
        Name of the socProfile
      '';
    };
    text = mkOption {
      type = types.str;
      default = "echo Template";
      description = ''
        write your shell context here
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
      type = types.nullOr types.path;
      default = null;
      description = ''
        The path for Your Configuration files
      '';
    };
    branch = mkOption {
      type = types.enum ["prod" "dev" "backport" "staging" "CI"];
      default = [];
      description = ''
        Which branch do you want to import in.
      '';
    };
    source = mkOption {
      default = {};
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
      default = {
        bin = [];
        source = [];
      };
    };
    runtimeInputs = mkOption {
      type = types.listOf types.str;
      default = [];
    };

    args = mkOption {
      type = types.listOf types.str;
      default = [];
    };
    makeSocProfile = mkOption {
      type = types.package;
    };
  };

  imports = [./makeSocProfile.nix];
}
