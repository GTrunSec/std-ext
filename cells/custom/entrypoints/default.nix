{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._common.library) makeExample;
  inherit (inputs.cells._writers.library) writeShellApplication;
in {
  a = makeExample {
    name = "1";
    text = "echo";
  };
}
