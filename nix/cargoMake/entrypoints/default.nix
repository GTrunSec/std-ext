{
  inputs,
  cell,
}: let
  inherit (cell) lib cargoMakeJobs;
  inherit (inputs.cells._writers.lib) writeConfiguration;
  inherit (inputs.cells._flow.lib) makeCargoMakeFlow;
in rec {
  test = writeConfiguration {
    name = "test-flow";
    format = "toml";
    language = "nix";
    source = cargoMakeJobs.default;
  };

  flow = makeCargoMakeFlow {
    source = test.passthru.data;
    args = ["format"];
  };
}
