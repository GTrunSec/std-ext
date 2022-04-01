{
  config,
  lib,
  pkgs,
  writeShellApplication,
  ...
}: let
  cfg = config.templates;
in {
  config.socProfile = {
    makeSocProfile = writeShellApplication {
      name = cfg.name;
      runtimeInputs = cfg.runtimeInputs;
      text = let
        command = lib.fileContents ./makeSocProfile.bash;
      in ''
        ${command}
        ${
          lib.optionalString (cfg.target == "nomad") ''
            ${pkgs.nomad}/bin/nomad job echo
          ''
        }
        ${cfg.text}
      '';
    };
  };
}
