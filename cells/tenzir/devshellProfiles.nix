{
  inputs,
  system,
}: let
  nixpkgs = inputs.nixpkgs;
  packages = inputs.self.packages.${system.host.system};
in {
  "" = _: {
    commands = [
      {
        package = packages.tenzir-threatbus;
        category = "tenzir";
      }
      {
        package = packages.tenzir-vast-release;
        category = "tenzir";
      }
    ];
  };
}
