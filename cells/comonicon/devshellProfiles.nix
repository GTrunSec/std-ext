{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs;
  inherit (cell) packages;
in {
  default = _: {
    commands = [
      {
        name = "julia";
        package = nixpkgs.julia_17-bin;
        category = "julia";
      }
      {
        package = packages.mycmd;
        category = "julia";
      }
    ];
  };
}
