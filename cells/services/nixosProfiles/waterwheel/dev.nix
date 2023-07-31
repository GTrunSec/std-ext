{ lib, pkgs, ... }:
{
  services.waterwheel = {
    enable = lib.mkForce false;
    # enable = true;
    # worker.enable = true;
    host = "http://localhost:8080";
    database.passwordFile = lib.mkForce (pkgs.writeText "text" "password");
    secrets.hmac_secret = lib.mkForce (pkgs.writeText "text" "shared");
  };

  services.rabbitmq = {
    enable = true;
  };

  services.postgresql = {
    enable = true;
    port = 5433;
    ensureDatabases = [ "waterwheel" ];
    ensureUsers = [ {
      name = "waterwheel";
      ensurePermissions = {
        "DATABASE waterwheel" = "ALL PRIVILEGES";
      };
    } ];
  };
}
