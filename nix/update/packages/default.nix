{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  nvfetcher = __inputs__.nvfetcher.packages.default;
in {
  inherit nvfetcher;
}
