{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writePiplelineApplication;
in {
  cmd = writePiplelineApplication {
    name = "cmd";
    runtimeInputs = [nixpkgs.julia_17-bin];
    # https://docs.julialang.org/en/v1/manual/multi-threading/#Starting-Julia-with-multiple-threads
    env.JULIA_NUM_THREADS = 4;
    path = ./.;
    args = ["cmd.jl"];
  };
  job = writePiplelineApplication {
    name = "job";
    runtimeInputs = [nixpkgs.julia_17-bin];
    # https://docs.julialang.org/en/v1/manual/multi-threading/#Starting-Julia-with-multiple-threads
    env.JULIA_NUM_THREADS = 4;
    path = ./.;
    args = ["job.jl"];
  };
}
