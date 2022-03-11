{
  inputs,
  cell,
}: let
  inherit (inputs) self;
  inherit (cell) packages;
in {
  default = _: {
    commands = [
      {
        package = packages.nvfetcher;
        category = "Update";
      }
      {
        package = self.packages.update-nvfetcher-update;
        category = "Update";
        help = "run nvfetcher with sources.toml <github-CI>";
      }
      {
        package = self.packages.update-nix-github-update;
        help = "run nvfetcher to update your github action version";
        category = "Update";
      }
    ];
  };
}
