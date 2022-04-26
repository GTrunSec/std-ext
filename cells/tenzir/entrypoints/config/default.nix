{
  inputs,
  cell,
}: let
  inherit (inputs) data-merge;
  inherit (cell) generators library;
  inherit (inputs.cells._modules.library) makeConfiguration;
  inherit (inputs.cells.makeConfiguration.library) makeConfig;
in {
  vast = {
    default.prod = makeConfig ["tenzir/config/vast/default" "prod" library.properties.vast.configFile] (data-merge.merge generators.vast.prod {
      vast.endpoint = "192.168.1.1:4000";
    });
  };
}
