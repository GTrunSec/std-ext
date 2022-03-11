{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
  zeek-action = inputs.cells.zeek-action.devshellProfiles.default;
in {
  default = _: {
    imports = [zeek-action];
    commands = [
      {
        package = self.packages.tenzir-threatbus;
        category = "tenzir-action";
      }
      {
        package = self.packages.tenzir-vast-release;
        category = "tenzir-action";
      }
      {
        package = self.packages.zeek-btest;
        category = "tenzir-action";
      }
      {
        package = self.packages.zeek-zeek-release;
        category = "tenzir-action";
      }
    ];
  };
}
