{
  config,
  lib,
  pkgs,
  writeShellApplication,
  ...
}:
with lib; let
  cfg = config.devshell;
in {
  options.devshell = {
    name = mkOption {
      type = types.str;
      default = "devshell";
      description = ''
        Name of the shell environment. It usually maps to the project name.
      '';
    };
    text = mkOption {
      type = types.str;
      default = "devshell";
      description = ''
        Name of the shell environment. It usually maps to the project name.
      '';
    };
    shell = mkOption {
      type = types.package;
      description = "shell Option";
    };
  };

  config.devshell = {
    shell = writeShellApplication {
      name = cfg.name;
      text = ''
        echo ${cfg.text}
      '';
    };
  };
}
