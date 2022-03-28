{
  cell,
  inputs,
}: let
  inherit (inputs) terranix nixpkgs;
  inherit (inputs.nixpkgs) system;
  inherit (inputs.cells.makes.library) makeScript;
  inherit (inputs.cells._templates.library) makeTemplate;
in {
  terraform-example = let
    terraformConfiguration = terranix.lib.terranixConfiguration {
      inherit system;
      modules = [./example.nix];
    };
  in
    makeTemplate {
      name = "terraform-nixos-example";
      target = "terraform";
      source = terraformConfiguration;
    };
}
