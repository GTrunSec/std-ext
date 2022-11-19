{
  inputs,
  cell,
}: let
  inherit (inputs.cells.writers.lib) writeClicheApplication;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.cells.common.lib.__inputs__.nixpkgs-hardenedlinux.overlays.default
  ];
in {
  example = writeClicheApplication {
    name = "example";
    path = ./example;
    env = {
      test = "aaa";
    };
    libraries = with nixpkgs.python3Packages; [
      six
      nixpkgs.python3Packages.sh
    ];
    runtimeInputs = [];
  };
}
