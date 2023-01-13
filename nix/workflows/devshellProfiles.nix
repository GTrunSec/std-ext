{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  default = _: {
    commands = [
      {
        package = nixpkgs.cargo-make;
        category = "workflows";
      }
      {
        package = cell.packages.process-compose;
        category = "workflows";
      }
    ];
  };
}
