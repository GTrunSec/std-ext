{
  config,
  lib,
  pkgs,
  writeShellApplication,
  inputs,
  ...
}: let
  inherit (inputs) self;
  cfg = config.templates;
in {
  config.templates = {
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
