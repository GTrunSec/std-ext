{ inputs, cell }:
let
  inherit (inputs.cells.writers.lib) writeConfig;
in
{
  test = writeConfig "test-flow.toml" cell.cargoMakeJobs.default;
}
