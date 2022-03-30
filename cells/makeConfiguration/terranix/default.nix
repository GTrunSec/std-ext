{
  cell,
  inputs,
}: let
  inherit (inputs) terranix nixpkgs;
  inherit (inputs.nixpkgs) system;
  inherit (inputs.cells._modules.library) makeConfiguration;
in {
  terraform-example-dev = let
    terraformConfiguration = terranix.lib.terranixConfiguration {
      inherit system;
      modules = [./example.nix];
    };
  in
    makeConfiguration {
      name = "terraform-nixos-example";
      branch = "dev";
      format = "nix";
      target = "terraform";
      source = terraformConfiguration;
    };
}
