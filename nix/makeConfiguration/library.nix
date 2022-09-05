{
  inputs,
  cell,
}: let
  inherit (inputs.cells._modules.library) makeConfiguration;
  inherit (inputs.cells.main.library) __inputs__;
  inherit (__inputs__.nickel-nix.packages) importNcl;
in {
  # inherit importNcl;

  makeConfig = settings: source: let
    path = builtins.elemAt settings 0;
    branch = builtins.elemAt settings 1;
    name = builtins.elemAt settings 2;
  in
    makeConfiguration {
      inherit name branch source;
      path = "cells-infra/infra/${path}";
      target = "regular";
    };
}
