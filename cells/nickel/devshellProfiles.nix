{
  inputs,
  system,
}: let
  nixpkgs = inputs.nixpkgs;
  nickel = inputs.nickel.defaultPackage.${system.host.system};
in {
  "" = _: {
    commands = [
      {
        package = nickel;
        category = "nickel";
        help = "Better configuration for less";
      }
      {
        package = nixpkgs.nomad;
      }
    ];
  };
}
