{
  config,
  lib,
  pkgs,
  writeShellApplication,
  inputs,
  ...
}: let
  inherit (inputs) cells;
in {
  config.templates = {
    makeConfiguration = let
      cfg = config.templates;
    in
      writeShellApplication {
        name = cfg.name;
        runtimeInputs =
          lib.optionals (cfg.language == "nickel") [cells.makeConfiguration.packages.nickel]
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
              ${command} | ${pkgs.nomad}/bin/nomad job validate -
            ''
          }
          ${cfg.text}
        '';
      };
  };
}
