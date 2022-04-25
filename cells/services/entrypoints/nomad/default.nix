{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells._modules.library) makeCommonNomad;
in {
  nixos = {
    airflow = {
      dev = makeCommonNomad "airflow" "dev" (nomadJobs.nixos.airflow {
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-airflow.dev";
      });
      prod = makeCommonNomad "airflow" "prod" (nomadJobs.nixos.airflow {
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-airflow.prod";
      });
    };

    waterwheel = {
      dev = makeCommonNomad "waterwheel" "dev" (nomadJobs.nixos.waterwheel {
        # flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-waterwheel.dev";
      });
      prod = makeCommonNomad "waterwheel" "prod" (nomadJobs.nixos.waterwheel {
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-waterwheel.prod";
      });
    };
  };

  containers = {
    elasticsearch = {
      dev = makeCommonNomad "elasticsearch" "dev" (nomadJobs.container.elasticsearch {
        driver = "podman";
        task = "dev";
        # job.elasticsearch = (nomadJobs.container.kibana {driver = "podman";}).job.elasticsearch;
      });
    };

    traefik = {
      dev = makeCommonNomad "traefik" "dev" (nomadJobs.container.traefik {
        task = "dev";
      });
      prod = makeCommonNomad "traefik" "prod" (nomadJobs.container.traefik {
        task = "prod";
      });
    };
  };
}
