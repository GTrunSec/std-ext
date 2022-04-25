{
  config,
  lib,
  pkgs,
  ...
}: {
  services.waterwheel = {
    host = "http://localhost:8080";
    database.passwordFile = lib.mkForce (pkgs.writeText "text" "password");
    secrets.hmac_secret = lib.mkForce (pkgs.writeText "text" "shared");
  };

  services.postgresql = {
    port = 5433;
  };
}
