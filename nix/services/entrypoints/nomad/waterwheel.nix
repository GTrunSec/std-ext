{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells.hashicorp.library) makeNomadJobs;
in {
  nixos = {
    dev = makeNomadJobs ["services/nomad/waterwheel/nixos" "dev" "dev.json"] (nomadJobs.nixos.waterwheel {
      # flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
      flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-waterwheel.dev";
    });
    prod = makeNomadJobs ["services/nomad/waterwheel/nixos" "prod" "prod.json"] (nomadJobs.nixos.waterwheel {
      flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-waterwheel.prod";
    });
  };
}
