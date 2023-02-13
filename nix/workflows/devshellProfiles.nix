{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  default = _: {
    commands = [
      {
        package = cell.packages.process-compose;
        category = "workflows";
      }
    ];
  };
  cargo-make = {
    commands = [
      {
        package = nixpkgs.cargo-make;
        category = "workflows";
      }
    ];
  };
}
