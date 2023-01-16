{
  inputs,
  cell,
}: let
  inherit (inputs.cells.writers.lib) writeClicheApplication;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.cells.common.lib.__inputs__.nixpkgs-hardenedlinux.overlays.default
  ];
in {
  example =
    (writeClicheApplication {
      inherit nixpkgs;
      name = "example";
      path = ./example;
      env = {
        test = "aaa";
      };
      libraries = ps:
        with ps; [
          six
          sh
        ];
      runtimeInputs = [];
    })
    // {
      process-compose = {
        disabled = false;
        availability = {
          restart = "always";
          backoff_seconds = 300;
        };
      };
    };
}
