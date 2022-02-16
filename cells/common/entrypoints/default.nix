{ inputs
, system
}:
let
  packages = inputs.self.packages.${system.build.system};
  library = inputs.self.library.${system.build.system};
  nixpkgs = inputs.nixpkgs;
  writeClicheApplication = library._writers-writeClicheApplication;
in
{
  common = writeClicheApplication {
    name = "common-cliche";
    dir = ./scripts;
    runtimeInputs = [ ];
  };
}
