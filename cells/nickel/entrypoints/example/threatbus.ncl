{
  "threatbus" = {
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
    }
}
