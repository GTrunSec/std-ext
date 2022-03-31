{
  inputs,
  cell,
}: let
  inherit (cell) dockerJobs library;
  inherit (inputs.cells._modules.library) makeConfiguration;
  inherit (inputs.cells.makes.library) makeSubstitution;

  name = "tenzir-" + builtins.baseNameOf ./.;

  justfile = makeSubstitution {
    name = "justfile";
    env = {
      __argFile__ = name;
    };
    source = ./justfile;
  };

  common = branch: source:
    makeConfiguration {
      inherit name;
      target = "docker-compose";
      inherit branch;
      searchPaths.file = [
        "${justfile}/justfile"
      ];
      searchPaths.bin = [];
      inherit source;
      format = "yaml";
    };
in {
  vast.prod = common "prod" (dockerJobs.vast.compose {});
}
