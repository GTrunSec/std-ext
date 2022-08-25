{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  default = _: {
    commands = [
      {
        package = nixpkgs.difftastic;
        category = "utils";
      }
      {
        package = nixpkgs.dasel;
        category = "utils";
      }
    ];
  };
}
