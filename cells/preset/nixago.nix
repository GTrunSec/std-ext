{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib.dev) mkNixago;
  inherit (inputs.std.lib) cfg;

  inherit (inputs) nixpkgs;
  inherit (inputs.cells.common.lib) __inputs__;

  l = nixpkgs.lib // builtins;
in {
  treefmt = (mkNixago cfg.treefmt) (cell.configs.treefmt.default
    // {
      packages = [
        nixpkgs.alejandra
        __inputs__.nixpkgs-release.legacyPackages.nodePackages.prettier
        nixpkgs.shfmt
        nixpkgs.nodePackages.prettier-plugin-toml
      ];
      devshell.startup.prettier-plugin-toml = l.stringsWithDeps.noDepEntry ''
        export NODE_PATH=${__inputs__.nixpkgs-release.legacyPackages.nodePackages.prettier-plugin-toml}/lib/node_modules:''${NODE_PATH-}
      '';
    });

  lefthook = (mkNixago cfg.lefthook) cell.configs.lefthook.default;

  conform = mkNixago cfg.conform cell.configs.conform.default;

  editorconfig = cfg.editorconfig (cell.configs.editorconfig.default
    // {
      hook.mode = "copy";
    });

  githubsettings = cfg.githubsettings cell.configs.githubsettings.default;

  cog = mkNixago cell.configs.cog.default;
}
