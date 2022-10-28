{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  nvfetcher = __inputs__.nvfetcher.defaultPackage;
in {
  inherit nvfetcher;
}
