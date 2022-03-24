{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
in {
  default = _: {
    commands = [
      {
        name = "julia";
        package = nixpkgs.julia_17-bin;
        category = "julia";
      }
      {
        package = self.packages.comonicon-mycmd;
        category = "julia";
      }
    ];
  };
}
