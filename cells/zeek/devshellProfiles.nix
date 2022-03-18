{
  inputs,
  cell,
}: let
  inherit (cell) packages devshellProfiles;
  inherit (inputs) nixpkgs self;
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
