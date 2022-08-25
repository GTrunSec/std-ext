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
        name = "julia";
        package = nixpkgs.julia_17-bin;
        category = "julia";
      }
      {
        package = entrypoints.mycmd;
        category = "julia";
      }
    ];
  };
}
