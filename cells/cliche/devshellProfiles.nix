{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) entrypoints;
in {
  default = _: {
    commands = [
      {
        package = entrypoints.example;
        category = "cliche";
      }
    ];
  };
}
