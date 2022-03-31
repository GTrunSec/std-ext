{version ? "1.1.2"}: let
  env.common = {};
in {
  version = "3";

  services.threatbus = {
    image = "tenzir/threatbus:${version}";
    restart = "always";
    environment = env.common;
    volumes = ["vastdata:/var/lib/vast"];
    ports = ["42000:42000"];
  };

  volumes = {
    vastdata = {};
  };
}
