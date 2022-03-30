{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) packages;
in {
  default = _: {
    commands = [
      {
        package =
          packages.difftastic;
        category = "utils";
      }
    ];
  };
}
