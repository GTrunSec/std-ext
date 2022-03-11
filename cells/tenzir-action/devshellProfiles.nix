{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
in {
  default = _: {
    imports = [];
    commands = [
      {
        package = self.packages.tenzir-threatbus;
        category = "tenzir-action";
      }
      {
        package = self.packages.tenzir-vast-release;
        category = "tenzir-action";
      }
    ];
  };
}
