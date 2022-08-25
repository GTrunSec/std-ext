let default_ = import "default.ncl" in
let resources = import "resources.ncl" in
{
  job."threatbus" = {
    group."nixpkgs" = {
      task."threatbus" = {
        driver = "nix",

        config = {
          packages = [
            "github:nixos/nixpkgs/nixos-21.05#bash",
            "github:nixos/nixpkgs/nixos-21.05#coreutils",
            "github:GTrunSec/threatbus2nix#threatbus-latest"
        ],
          command = ["/bin/threatbus", "-c", "/config.example.yaml"],
        },
      } & resources,
    },
  } & default_
}
