{ inputs, cell }:
let
  inherit (cell) entrypoints;
  inherit (inputs) nixpkgs;
in
{
  default = _: {
    commands = [
      {
        package = nixpkgs.nvfetcher;
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
    ];
    env = [ {
      name = "LC_ALL";
      value = "en_US.UTF-8";
    } ];
  };
}
