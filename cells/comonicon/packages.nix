{ inputs, cell }:
let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.cells.common.lib.__inputs__.julia2nix.overlays.default
  ];
in
{
  julia-wrapped = nixpkgs.lib.julia-wrapped {
    package = nixpkgs.julia_18-bin;
    makeWrapperArgs = [
      "--add-flags --compile=min"
      "--add-flags -O0"
    ];
    enable = {
      python = inputs.nixpkgs.python3.buildEnv.override {
        extraLibs = with nixpkgs.python3Packages; [ six ];
      };
    };
  };
}
