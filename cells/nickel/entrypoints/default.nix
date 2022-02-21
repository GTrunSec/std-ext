{
  inputs,
  system,
}:
let
  packages = inputs.self.packages.${system.build.system};
  library = inputs.self.library.${system.build.system};
  nixpkgs = inputs.nixpkgs;
  nickelTemplate = library._templates-nickelTemplate;
in
{
  threatbus = nickelTemplate {
    name = "threatbus";
    format = "json";
    file = ./example/threatbus.ncl;
  };
}
