{
  inputs,
  cell,
}: let
  inherit (inputs) data-merge;
  inherit (cell) generator;
  inherit (inputs.cells._modules.library) makeConfiguration;

  name = builtins.baseNameOf ./.;

  common = branch: source:
    makeConfiguration {
      inherit name;
      target = "regular";
      inherit branch;
      inherit source;
      format = "json";
    };

  state-prod = data-merge.merge generator.vast.prod {
    vast.endpoint = "192.168.1.1:4000";
  };
in {
  prod = common "prod" state-prod;
}
