{
  inputs,
  cell,
}: let
  inherit (cell) cargoMakeJobs;
  inherit (inputs.cells.writers.lib) writeConfig;
  inherit (inputs.cells.workflows.lib) mkCargoMake;
  l = inputs.nixpkgs.lib // builtins;
in {
  flow = mkCargoMake {
    source = writeConfig "test-flow.toml" cargoMakeJobs.default;
    args = ["format"];
  };
  single = cell.lib.mkProcessCompose {
    processes.simple = {
      command = l.getExe inputs.cells.cliche.entrypoints.example;
    };
  };
}
