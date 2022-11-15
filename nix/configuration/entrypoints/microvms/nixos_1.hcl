job "microvms" {
  datacenters = ["dc1"]
  type        = "batch"
  namespace   = "default"

  group "nomad" {
    task "nixos_1" {
      driver = "nix"

      resources {
        memory = 4000
        cpu = 3000
      }

      config {
        nixos = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad_nixos_1"
      }
    }
  }
}
