{
  inputs,
  cell,
}: let
  inherit (inputs) cells;
  inherit (cell) packages entrypoints;
in {
  default = _: {
    commands = [
      {
        package = packages.nvfetcher;
        category = "Update";
      }
      {
        package = entrypoints.nvfetcher-update;
        category = "Update";
        help = "run nvfetcher with sources.toml <github-CI>";
      }
      {
        package = entrypoints.nix-github-update;
        help = "run nvfetcher to update your github action version";
        category = "Update";
      }
    ];
  };
}
