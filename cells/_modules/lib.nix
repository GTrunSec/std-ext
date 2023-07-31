{ inputs, cell }:
let
  nixpkgs = inputs.nixpkgs.appendOverlays [ ];
  inherit (inputs.cells.writers.lib) writeShellApplication;
  eval = (import ./modules) nixpkgs;
in
{
  # configuration = templates:
  #   (eval {
  #     configuration = {inherit templates;};
  #     extraSpecialArgs = {inherit inputs cell writeShellApplication;};
  #   })
  #   .config
  #   .templates
  #   .configuration;
}
