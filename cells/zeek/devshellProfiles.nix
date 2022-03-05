{
  inputs,
  cell,
}: let
  inherit (cell) packages devshellProfiles;
  inherit (inputs) nixpkgs;
in {
  default = _: {
    commands = [
      {
        package = packages.zeek-release;
        category = "zeek";
      }
      {
        package = packages.btest;
        category = "zeek";
      }
    ];
  };
}
