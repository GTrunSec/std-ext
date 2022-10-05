{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.lib) writeConfig;
in {
  test = writeConfig "test-flow" "toml" cell.cargoMakeJobs.default;
}
