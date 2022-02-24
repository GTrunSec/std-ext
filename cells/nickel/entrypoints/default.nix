{
  inputs,
  system,
}: let
  packages = inputs.self.packages.${system.build.system};
  library = inputs.self.library.${system.build.system};
  nixpkgs = inputs.nixpkgs;
  nickelTemplate = library._templates-nickelTemplate;
in {
  threatbus-nomad-nix = nickelTemplate {
    name = "threatbus";
    format = "json";
    file = ./tenzir/threatbus-nomad-nix.ncl;
  };
}
