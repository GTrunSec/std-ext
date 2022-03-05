{
  inputs,
  cell,
}: let
  inherit (cell) packages library devshellProfiles;
  inherit (inputs) nixpkgs;
in {
  default = _: {
    imports = [devshellProfiles.zeek-action];
    commands = [
      {
        package = packages.tenzir-threatbus;
        category = "tenzir-action";
      }
      {
        package = packages.tenzir-vast-release;
        category = "tenzir-action";
      }
      {
        package = packages.zeek-btest;
        category = "tenzir-action";
      }
      {
        package = packages.zeek-zeek-release;
        category = "tenzir-action";
      }
    ];
  };
}
