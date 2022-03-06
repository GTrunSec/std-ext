{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
in {
  default = _: {
    commands = [
      {
        package = self.packages.cliche-example;
        category = "cliche";
      }
    ];
  };
}
