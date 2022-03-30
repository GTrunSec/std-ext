{
  inputs,
  cell,
}: let
  inherit (cell) packages;
in {
  default = _: {
    commands = [
      {
        package = packages.zeek-release;
        category = "zeek";
      }
      {
        name = "zeek-script";
        package = packages.zeekscript;
        category = "zeek";
      }
      {
        package = packages.btest;
        category = "zeek";
      }
    ];
  };
}
