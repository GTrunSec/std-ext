{
  inputs,
  cell,
}: let
  inherit (inputs.cells._modules.library) makeConfiguration;
in {
  makeNomadJobs = settings: source: let
    path = builtins.elemAt settings 0;
    branch = builtins.elemAt settings 1;
    name = builtins.elemAt settings 2;
  in
    makeConfiguration {
      inherit name branch source;
      path = "cells-infra/infra/${path}";
      target = "nomad";
      format = "json";
    };
}
