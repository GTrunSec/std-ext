{
  inputs,
  cell,
}: let
  inherit (inputs.nickel-nix.packages) importNcl;
  inherit (inputs.cells._modules.library) makeConfiguration;
in {
  inherit importNcl;

  makeRegular = branch: source:
    makeConfiguration {
      name = "makeRegularConfig";
      inherit branch source;
      target = "regular";
      format = "yaml";
    };
}
