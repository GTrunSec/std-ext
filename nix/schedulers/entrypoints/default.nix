{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells.writers.lib) writePiplelineApplication;
in {
  tenzir-config = writePiplelineApplication {
    name = "tenzir-config";
    runtimeInputs = [nixpkgs.julia_18-bin];
    # https://docs.julialang.org/en/v1/manual/multi-threading/#Starting-Julia-with-multiple-threads
    threads = 12;
    path = ./.;
    args = ["tenzir-config.jl"];
  };
  job = writePiplelineApplication {
    name = "job";
    runtimeInputs = [nixpkgs.julia_18-bin];
    path = ./.;
    args = ["job.jl"];
  };
}
