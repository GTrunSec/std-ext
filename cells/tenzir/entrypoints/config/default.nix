{
  inputs,
  cell,
}: let
  inherit (inputs) data-merge;
  inherit (cell) generators;
  inherit (inputs.cells.makeConfiguration.library) makeRegular;
in {
  default = {
    vast.prod = makeRegular "prod" (data-merge.merge generators.vast.prod {
      vast.endpoint = "192.168.1.1:4000";
    });
  };
}
