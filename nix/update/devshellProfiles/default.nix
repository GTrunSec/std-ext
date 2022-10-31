{
  inputs,
  cell,
}: let
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
        package = entrypoints.nvfetcher-update-force;
        category = "Update";
        help = "run nvfetcher with sources.toml <github-CI> for force option";
      }
      {
        package = entrypoints.nix-github-update;
        help = "run nvfetcher to update your github action version";
        category = "Update";
      }
    ];
    env = [
      {
        name = "LC_ALL";
        value = "en_US.UTF-8";
      }
    ];
  };
}
