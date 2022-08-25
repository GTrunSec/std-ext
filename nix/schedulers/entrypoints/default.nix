{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writePiplelineApplication;
in {
  tenzir-config = writePiplelineApplication {
    name = "tenzir-config";
    runtimeInputs = [nixpkgs.julia_17-bin];
    # https://docs.julialang.org/en/v1/manual/multi-threading/#Starting-Julia-with-multiple-threads
    threads = 12;
    path = ./.;
    args = ["tenzir-config.jl"];
  };
  job = writePiplelineApplication {
    name = "job";
    runtimeInputs = [nixpkgs.julia_17-bin];
    path = ./.;
    args = ["job.jl"];
  };
}
