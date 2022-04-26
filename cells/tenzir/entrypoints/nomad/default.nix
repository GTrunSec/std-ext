{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells.hashicorp.library) makeNomadJobs;
in {
  vast = {
    nixos = {
      prod = makeNomadJobs ["tenzir/nomad/vast/nixos" "prod" "prod.json"] (nomadJobs.nixos.vast {
        flake = "${self.outPath}#${nixpkgs.system}.tenzir.nixosProfiles.nomad.vast.prod";
      });
      dev = makeNomadJobs ["tenzir/nomad/vast/nixos" "dev" "dev.json"] (nomadJobs.nixos.vast {
        flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad.vast.dev";
        #flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-tenzir-opencti";
      });
    };
  };

  containers = {
  };
}
