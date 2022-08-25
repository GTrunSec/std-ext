{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeClicheApplication;
in {
  example = writeClicheApplication {
    name = "example";
    path = ./example;
    env = {
      test = "aaa";
    };
    libraries = with nixpkgs.python3Packages; [six];
    runtimeInputs = [];
  };
}
