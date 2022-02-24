job "threatbus" {
  datacenters = ["dc1"]
  type        = "batch"

  group "nixpkgs" {
    task "threatbus" {
      driver = "nix"

      resources {
        memory = 1000
        cpu = 3000
      }

      template {
        destination = "config.example.yaml"
        data = file("./config.example.yaml")
      }
      config {
        packages = [
          "github:nixos/nixpkgs/nixos-21.11#bash",
          "github:nixos/nixpkgs/nixos-21.11#coreutils",
          "github:GTrunSec/threatbus2nix#threatbus-latest"
        ]
        command = ["/bin/threatbus", "-c", "/config.example.yaml"]
      }
    }
  }
}
