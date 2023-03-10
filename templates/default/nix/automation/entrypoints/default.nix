{
  inputs,
  cell,
}: let
  inherit (inputs.std-ext.writers.lib) writeShellApplication;
  inherit (inputs) self nixpkgs std;
in {
}
