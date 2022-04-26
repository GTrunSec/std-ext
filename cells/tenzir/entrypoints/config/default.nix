{
  inputs,
  cell,
}: let
  inherit (inputs) data-merge;
  inherit (cell) generators;
  inherit (inputs.cells._modules.library) makeConfiguration;

  name = "tenzir-" + builtins.baseNameOf ./.;

  common = branch: source:
    makeConfiguration {
      inherit name branch source;
      target = "regular";
      format = "yaml";
    };
in {
  default = {
    vast.prod = common "prod" (data-merge.merge generators.vast.prod {
      vast.endpoint = "192.168.1.1:4000";
    });
  };
}
