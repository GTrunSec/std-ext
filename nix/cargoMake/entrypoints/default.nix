{
  inputs,
  cell,
}: let
  inherit (cell) lib cargoMakeJobs;
  inherit (inputs.cells._writers.lib) writeConfig;
  inherit (inputs.cells._flow.lib) makeCargoMakeFlow;
in rec {
  flow = makeCargoMakeFlow {
    source = writeConfig "test-flow" "toml" cargoMakeJobs.default;
    args = ["format"];
  };
}
