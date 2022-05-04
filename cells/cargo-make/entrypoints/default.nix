{
  inputs,
  cell,
}: let
  inherit (cell) library cargoMakeJobs;
  inherit (inputs.cells._writers.library) writeConfigurationFromLang;
in {
  flow = writeConfigurationFromLang {
    name = "flow";
    format = "toml";
    language = "nix";
    target = "cargo-make";
    source = cargoMakeJobs.job_a;
  };
}
