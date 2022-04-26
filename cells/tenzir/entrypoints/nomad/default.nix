{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells.hashicorp.library) makeNomadJobs;
in {
  nixos = {
    vast = {
      prod = makeNomadJobs "vast" "prd" (nomadJobs.nixos.vast {
        flake = "${self.outPath}#${nixpkgs.system}.tenzir.nixosProfiles.nomad-vast.prod";
      });
      dev = makeNomadJobs "vast" "dev" (nomadJobs.nixos.airflow {
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-vast.dev";
        #flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-tenzir-opencti";
      });
    };
  };

  containers = {
  };
}
