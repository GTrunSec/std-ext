{
  inputs,
  cell,
}: let
  inherit (cell) packages;
in {
  default = _: {
    commands = [
      {
        package = packages.threatbus;
        category = "tenzir";
      }
      {
        package = packages.vast-release;
        category = "tenzir";
      }
    ];
  };
}
