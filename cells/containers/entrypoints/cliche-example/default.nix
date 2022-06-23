{
  inputs,
  cell,
}: let
  inherit (cell) library packages;
  inherit (inputs.cells._writers.library) writeConfiguration;

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
    writeConfiguration {
      inherit name;
      target = "docker";
      # searchPaths.file = [
      #   "${justfile}/justfile"
      # ];
      # searchPaths.bin = [];
      format = "raw";
    };
in {
  prod = common "prod";
}
