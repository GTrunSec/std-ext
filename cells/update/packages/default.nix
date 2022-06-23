{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) inputs';
  nvfetcher = inputs'.nvfetcher.defaultPackage;
in {
  inherit nvfetcher;
}
