{
  inputs,
  cell,
}: let
  inherit (cell) packages library;
  inherit (inputs) nixpkgs;
  inputsSystem = {inputs.nixpkgs.legacyPackages."${nixpkgs.system}" = nixpkgs;};
in {
  nickel = library.importNcl ./shell.ncl inputsSystem.inputs;
  default = _: {
    commands = [
      {
        package = packages.nickel;
        category = "Configuration";
        help = "Better configuration for less";
      }
      {
        package = nixpkgs.cue;
        category = "Configuration";
        help = "Validate, define, and use dynamic and text-based data";
      }
    ];
  };
}
