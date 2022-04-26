{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells.hashicorp.library) makeNomadJobs;
in {
  nixos = {
    airflow = {
      dev = makeNomadJobs "airflow" "dev" (nomadJobs.nixos.airflow {
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-airflow.dev";
      });
      prod = makeNomadJobs "airflow" "prod" (nomadJobs.nixos.airflow {
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-airflow.prod";
      });
    };

    waterwheel = {
      dev = makeNomadJobs "waterwheel" "dev" (nomadJobs.nixos.waterwheel {
        # flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-waterwheel.dev";
      });
      prod = makeNomadJobs "waterwheel" "prod" (nomadJobs.nixos.waterwheel {
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-waterwheel.prod";
      });
    };
  };

  containers = {
    elasticsearch = {
      dev = makeNomadJobs "elasticsearch" "dev" (nomadJobs.container.elasticsearch {
        driver = "podman";
        task = "dev";
        # job.elasticsearch = (nomadJobs.container.kibana {driver = "podman";}).job.elasticsearch;
      });
    };

    traefik = {
      dev = makeNomadJobs "traefik" "dev" (nomadJobs.container.traefik {
        task = "dev";
      });
      prod = makeNomadJobs "traefik" "prod" (nomadJobs.container.traefik {
        task = "prod";
      });
    };
  };
}
