job "threatbus" {
  datacenters = ["dc1"]
  type        = "batch"
  namespace   = "tenzir"

  group "nix" {
    task "raw_exec" {
      driver = "raw_exec"

      resources {
        memory = 1000
        cpu = 3000
      }

      config {
        command = "nix"
        args = [
          "develop",
          "-Lv",
          "/home/gtrun/ghq/github.com/GTrunSec/threatbus2nix/devshell",
          "-c",
          "threatbus",
          "-c",
          "/home/gtrun/ghq/github.com/GTrunSec/threatbus2nix/conf/config.example.yaml",
        ]
      }
    }
  }
}
