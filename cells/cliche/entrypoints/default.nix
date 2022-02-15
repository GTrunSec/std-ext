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
  exmaple = writeClicheApplication {
    name = "exmaple-cliche";
    dir = ./example;
    runtimeInputs = [  ];
  };
}
