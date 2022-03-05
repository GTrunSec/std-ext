{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs packages;
in {
  default = _: {
    commands = [
      {
        package = packages.cliche-example;
        category = "cliche";
      }
    ];
  };
}
