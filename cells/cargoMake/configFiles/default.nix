{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.library) writeConfiguration;
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
