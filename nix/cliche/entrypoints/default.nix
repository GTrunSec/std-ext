{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells.writers.lib) writeClicheApplication;
in {
  example = writeClicheApplication {
    name = "example";
    path = ./example;
    env = {
      test = "aaa";
    };
    libraries = with nixpkgs.python3Packages; [
      six
      inputs.cells.common.lib.__inputs__.nixpkgs-hardenedlinux.python.packages.sh
    ];
    runtimeInputs = [];
  };
}
