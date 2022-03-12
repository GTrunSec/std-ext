{
  config,
  lib,
  pkgs,
  inputs,
  writeShellApplication,
  ...
}: let
  cfg = config.templates;
  inherit (inputs.self) packages;
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
      type = types.enum ["nomad" "terraform" "podman" "docker"];
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
      default = "echo Template";
      description = ''
        Which format do you want to generate in.
      '';
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
  };

  config.templates = {
    makeConfiguration = let
      target = cfg.target;
    in
      writeShellApplication {
        name = cfg.name;
        runtimeInputs =
          lib.optionals (cfg.language == "nickel") [packages.makeConfiguration-nickel]
          ++ lib.optionals (cfg.language == "cue") [pkgs.cue]
          ++ lib.optionals (cfg.language == "nix") []
          ++ cfg.runtimeInputs;
        text = let
          command = lib.removeSuffix "\n\n\n\n" ''
            ${lib.optionalString (cfg.language == "nickel") ''
              nickel -f ${cfg.path}/${builtins.concatStringsSep " " cfg.args} export --format ${cfg.format}
            ''}
            ${lib.optionalString (cfg.language == "cue") "
              cue export ./${cfg.path} -e ${builtins.concatStringsSep " " cfg.args} --out=${cfg.format}
              "}
            ${lib.optionalString (cfg.language == "nix") "
              cue export ./${cfg.path} -e ${builtins.concatStringsSep " " cfg.args} --out=${cfg.format}
              "}
          '';
        in ''
          ${command}
          ${
            lib.optionalString (cfg.target == "nomad") ''
              ${command} | ${packages.hashicorp-nomad}/bin/nomad job validate -
            ''
          }
          ${cfg.text}
        '';
      };
  };
}
