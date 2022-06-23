{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.library) writeConfiguration;
in {
  makeNomadJobs = settings: source: let
    dir = builtins.elemAt settings 0;
    branch = builtins.elemAt settings 1;
    name = builtins.elemAt settings 2;
  in
    writeConfiguration {
      inherit name source;
      target = "nomad";
      format = "json";
    };
}
