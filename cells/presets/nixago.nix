{ inputs, cell }:
let
  inherit (inputs.std.lib.dev) mkNixago;
  inherit (inputs.std.lib) cfg;

  inherit (inputs) nixpkgs;
  inherit (inputs.cells.common.lib) __inputs__;

  l = nixpkgs.lib // builtins;
in
{
  treefmt = (mkNixago cfg.treefmt) (
    cell.configs.treefmt.default
    // {
      packages = [
        __inputs__.nixfmt.packages.default
        nixpkgs.nodePackages.prettier
        nixpkgs.shfmt
        nixpkgs.nodePackages.prettier-plugin-toml
      ];
    }
  );

  lefthook = (mkNixago cfg.lefthook) cell.configs.lefthook.default;

  conform = mkNixago cfg.conform cell.configs.conform.default;

  editorconfig = mkNixago cfg.editorconfig (
    cell.configs.editorconfig.default // { hook.mode = "copy"; }
  );

  githubsettings =
    mkNixago cfg.githubsettings
      cell.configs.githubsettings.default;

  cog = mkNixago cell.configs.cog.default;
}
