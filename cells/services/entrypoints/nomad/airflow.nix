{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells.hashicorp.library) makeNomadJobs;
in {
  nixos = {
    dev = makeNomadJobs ["services/nomad/airflow/nixos" "dev" "dev.json"] (nomadJobs.nixos.airflow {
      flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-airflow.dev";
    });
    prod = makeNomadJobs ["services/nomad/airflow/nixos" "prod" "prod.json"] (nomadJobs.nixos.airflow {
      flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-airflow.prod";
    });
  };
}
