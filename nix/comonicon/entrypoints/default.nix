{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells.writers.lib) writeComoniconApplication;
in {
  mycmd = writeComoniconApplication {
    name = "mycmd";
    runtimeEnv = {
      b = "1";
    };
    runtimeInputs = [];
    path = ./mycmd;
    args = ["mycmd.jl"];
  };
}
