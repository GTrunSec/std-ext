{
  inputs,
  cell,
}: let
  nvfetcher = inputs.nvfetcher.defaultPackage;
in {
  inherit nvfetcher;
}
