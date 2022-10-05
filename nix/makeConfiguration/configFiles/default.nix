{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.lib) writeConfig;
in {
  writeConfig = writeConfig "json" "json" {
    name = "a";
    value = "s";
  };
}
