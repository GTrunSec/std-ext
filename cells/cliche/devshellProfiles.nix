{ inputs, cell }:
let
  inherit (cell) entrypoints;
in
{
  default = _: {
    commands = [ {
      package = entrypoints.example;
      category = "cliche";
    } ];
  };
}
