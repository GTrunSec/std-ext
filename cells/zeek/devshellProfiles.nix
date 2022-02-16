{
  inputs,
  system,
}:
let
  nixpkgs = inputs.nixpkgs;
  packages = inputs.self.packages.${system.host.system};
in
{
  "" = _: {
    commands = [
      {
        package = packages.zeek-zeek-release;
        category = "zeek";
      }
      {
        package = packages.zeek-btest;
        category = "zeek";
      }
    ];
  };
}
