{
  inputs,
  cell,
}: let
  inherit (inputs.cells.writers.lib) writeConfig;
in {
  writeConfig = writeConfig "test.json" {
    name = "a";
    value = "s";
  };
}
