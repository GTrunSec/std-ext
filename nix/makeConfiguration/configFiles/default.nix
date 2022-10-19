{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.lib) writeConfig;
in {
  writeConfig = writeConfig "test.json" {
    name = "a";
    value = "s";
  };
}
