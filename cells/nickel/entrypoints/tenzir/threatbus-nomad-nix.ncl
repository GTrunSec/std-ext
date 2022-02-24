let default_ = import "nomad/default.ncl" in
{
  job."threatbus" = {
    group."nixpkgs" = {
      task."threatbus" = {
        driver = "nix",

        resources = {
          memory = 1000,
          cpu = 3000,
        },

        config = {
          packages = [
            "github:nixos/nixpkgs/nixos-21.05#bash",
            "github:nixos/nixpkgs/nixos-21.05#coreutils",
            "github:GTrunSec/threatbus2nix#threatbus-latest"
        ],
          command = ["/bin/threatbus", "-c", "/config.example.yaml"],
        },
      },
    },
  } & default_
}
