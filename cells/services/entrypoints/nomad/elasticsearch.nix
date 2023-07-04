{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells.hashicorp.lib) makeNomadJobs;
in {
  containers = {
    dev = makeNomadJobs ["services/nomad/elasticsearch/container" "dev" "dev.json"] (nomadJobs.container.elasticsearch {
      driver = "podman";
      task = "dev";
      # job.elasticsearch = (nomadJobs.container.kibana {driver = "podman";}).job.elasticsearch;
    });
  };
}
