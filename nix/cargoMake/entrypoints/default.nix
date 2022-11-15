{
  inputs,
  cell,
}: let
  inherit (cell) cargoMakeJobs;
  inherit (inputs.cells.writers.lib) writeConfig;
  inherit (inputs.cells.workflows.lib) mkCargoMake;
in {
  flow = mkCargoMake {
    source = writeConfig "test-flow.toml" cargoMakeJobs.default;
    args = ["format"];
  };
}
