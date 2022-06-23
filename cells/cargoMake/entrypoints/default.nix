{
  inputs,
  cell,
}: let
  inherit (cell) library cargoMakeJobs;
  inherit (inputs.cells._writers.library) writeConfiguration;
  inherit (inputs.cells._flow.library) makeCargoMakeFlow;
in rec {
  test = writeConfiguration {
    name = "test-flow";
    format = "toml";
    language = "nix";
    source = cargoMakeJobs.job_a;
  };

  flow = makeCargoMakeFlow {
    source = test.passthru.data;
    args = ["format"];
  };
}
