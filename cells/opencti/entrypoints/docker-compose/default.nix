{
  inputs,
  cell,
}: let
  inherit (cell) dockerJobs library;
  inherit (inputs.cells._modules.library) makeConfiguration;
  inherit (inputs.cells.makes.library) makeSubstitution;

  name = "opencti-docker-compose";

  justfile = makeSubstitution {
    name = "justfile";
    env = {
      __argFile__ = name;
    };
    source = ./justfile;
  };
  common = branch:
    makeConfiguration {
      inherit name;
      target = "docker-compose";
      inherit branch;
      searchPaths.source = ["${justfile}/justfile"];
      searchPaths.bin = [];
      source = dockerJobs.compose {};
      format = "yaml";
    };
in {
  prod = common "prod";
}
