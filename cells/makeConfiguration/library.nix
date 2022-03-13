{ inputs, cell }:
let
  inherit (inputs.nickel-nix.packages) importNcl;
in
{
  inherit importNcl;
}
