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
    runtimeInputs = [nixpkgs.julia_18-bin];
    path = ./.;
    args = ["mycmd.jl"];
  };
}
