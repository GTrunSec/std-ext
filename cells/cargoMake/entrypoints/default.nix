{
  inputs,
  cell,
}: let
  inherit (cell) library cargoMakeJobs;
  inherit (inputs.cells._writers.library) writeConfigurationFromLang;
  inherit (inputs.cells._flow.library) makeCargoMakeFlow;
in rec {
  test = writeConfigurationFromLang {
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
