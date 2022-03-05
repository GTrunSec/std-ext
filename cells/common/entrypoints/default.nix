{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) packages library;
  inherit (inputs.cells._writers.library) writeClicheApplication;
in {
  common = writeClicheApplication {
    name = "common-cliche";
    dir = ./scripts;
    runtimeInputs = [];
  };
}
