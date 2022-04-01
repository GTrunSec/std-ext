{
  inputs,
  cell,
}: let
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
