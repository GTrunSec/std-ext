{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [];
  inherit (inputs.cells._writers.library) writeShellApplication;
  eval = (import ./modules) nixpkgs;
in {
  # makeConfiguration = templates:
  #   (eval {
  #     configuration = {inherit templates;};
  #     extraSpecialArgs = {inherit inputs cell writeShellApplication;};
  #   })
  #   .config
  #   .templates
  #   .makeConfiguration;
}
