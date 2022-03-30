{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
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
