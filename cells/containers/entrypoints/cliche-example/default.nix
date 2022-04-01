{
  inputs,
  cell,
}: let
  inherit (cell) library packages;
  inherit (inputs.cells._modules.library) makeConfiguration;
  inherit (inputs.cells.makes.library) makeSubstitution;

  name = "containers-" + builtins.baseNameOf ./.;

  justfile = makeSubstitution {
    name = "justfile";
    env = {
      __argName__ = packages.cliche-example.imageName;
      __argTag__ = packages.cliche-example.imageTag;
    };
    source = ./justfile;
  };

  common = branch:
    makeConfiguration {
      inherit name;
      target = "docker";
      inherit branch;
      searchPaths.file = [
        "${justfile}/justfile"
      ];
      searchPaths.bin = [];
      format = "raw";
    };
in {
  prod = common "prod";
}
