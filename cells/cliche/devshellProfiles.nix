{ inputs
, system
}:
let
  nixpkgs = inputs.nixpkgs;
  packages = inputs.self.packages.${system.host.system};
in
{
  "" = _: {
    commands = [
      {
        package = packages.cliche-exmaple;
        category = "cliche";
      }
    ];
  };
}
