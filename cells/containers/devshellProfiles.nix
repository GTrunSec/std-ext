{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs cells;
in {
  default = _: {
    imports = [];
    commands = [
      {
        package = nixpkgs.docker-compose;
        category = "docker";
      }
    ];
  };
}
