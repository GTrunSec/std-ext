{
  inputs,
  cell,
}: let
  inherit (inputs.std-utils.nu.lib) writeNuInclude;
in {
  vast-query = writeNuInclude {
    name = "logging";
    script = ./json.nu;
  };
}
