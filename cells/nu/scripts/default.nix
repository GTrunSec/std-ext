{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (__inputs__.nuenv.lib) mkNushellScript;
in
{
  # vast-query = writeNuInclude {
  #   name = "logging";
  #   script = ./json.nu;
  # };
}
