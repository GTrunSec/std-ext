{lib, ...}: {
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
      default = "";
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
      type = types.enum ["nomad" "terraform" "podman" "docker" "k8s" "docker-compose" "regular"];
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
    format = mkOption {
      type = types.enum ["yaml" "toml" "json" "nix" "raw"];
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
      description = "Disk images";
      default = {};
      type = lib.types.submodule {
        options = {
          bin = mkOption {
            type = types.listOf types.str;
            default = [];
          };
          source = mkOption {
            type = types.listOf (types.either types.str types.path);
            default = [];
          };
          file = mkOption {
            type = types.listOf (types.either types.str types.path);
            default = [];
          };
        };
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
    makeConfigurationFromLang = mkOption {
      type = types.package;
    };
    makeConfiguration = mkOption {
      type = types.package;
    };
  };

  imports = [./makeConfigurationFromLang.nix ./makeConfiguration.nix];
}
