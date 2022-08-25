{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells.hashicorp.library) makeNomadJobs;
in {
  container = {
    dev = makeNomadJobs ["services/nomad/traefik/container" "dev" "dev.json"] (nomadJobs.container.traefik {
      task = "dev";
    });
    prod = makeNomadJobs ["services/nomad/traefik/container" "dev" "dev.json"] (nomadJobs.container.traefik {
      task = "prod";
    });
  };
}
