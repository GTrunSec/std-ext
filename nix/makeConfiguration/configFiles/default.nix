{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.library) writeConfig;
in {
  writeConfig = writeConfig "json" "json" {
    name = "a";
    value = "s";
  };
}
