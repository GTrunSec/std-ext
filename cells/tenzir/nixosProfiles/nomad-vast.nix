{
  config,
  lib,
  pkgs,
  generator,
  ...
}: {
  config.services.vast = {
    settings = lib.mkForce generator.prod;
    extraConfigFile = null;
  };
}
