{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.library) writeConfigurationFromLang;
in {
  makeNomadJobs = settings: source: let
    dir = builtins.elemAt settings 0;
    branch = builtins.elemAt settings 1;
    name = builtins.elemAt settings 2;
  in
    writeConfigurationFromLang {
      inherit name source;
      target = "nomad";
      format = "json";
    };
}
