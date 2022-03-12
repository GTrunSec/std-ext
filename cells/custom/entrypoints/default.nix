{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._modules.library) makeConfiguration;
  inherit (inputs.cells._writers.library) writeShellApplication;
in {
  a = makeConfiguration {
    target = "nomadd";
    language = "nickel";
    text = "echo 1";
  };
}
