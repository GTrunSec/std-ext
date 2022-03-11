{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeClicheApplication;
in {
  common = writeClicheApplication {
    name = "common-cliche";
    path = ./scripts;
    runtimeInputs = [];
  };
}
