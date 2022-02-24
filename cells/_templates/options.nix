{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.templates.nickel;
in {
  options.templates.nickel = {
    format = lib.mkOption {
      type = lib.enum ["user" "tap" "bridge"];
      default = "json";
      description = "";
    };
  };
}
