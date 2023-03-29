{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  toolchain = {
    commands = [
      {
        package = cell.packages.tuc;
        help = "When cut doesn't cut it: https://github.com/riquito/tuc";
      }
      {
        package = cell.packages.zed;
      }
      {
        package = nixpkgs.jq;
      }
      {
        package = cell.entrypoints.polars;
        help = "A wrapped CLI for the polars commands";
      }
      {
        package = cell.entrypoints.cli;
        help = "A wrapped CLI for the julia data commands";
      }
    ];
  };
}
