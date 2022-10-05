{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.lib) writeConfiguration;
in {
  test =
    (writeConfiguration {
      name = "test-flow";
      format = "toml";
      language = "nix";
      source = cell.cargoMakeJobs.default;
    })
    .data;
}
