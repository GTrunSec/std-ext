job "drone" {
  datacenters = ["dc1"]
  type        = "service"

  group "ci-cd" {
    network {
      port "http" { to = 801 }
    }
    task "drone" {
      driver = "podman"

      meta {
        BUILD_NUMBER = "${DRONE_BUILD_NUMBER}"
        TAG = "${DRONE_TAG}"
      }

      config {
        image = "docker://drone/drone:2.11.0"
        ports = ["http"]
      }
      service {
        name = "drone"
        port = "http"

        check {
          type     = "tcp"
          interval = "10s"
          timeout  = "4s"
        }
      }
    }
  }
}
