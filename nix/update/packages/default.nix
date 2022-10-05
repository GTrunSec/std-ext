{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.lib) __inputs__;
  nvfetcher = __inputs__.nvfetcher.defaultPackage;
in {
  inherit nvfetcher;
}
