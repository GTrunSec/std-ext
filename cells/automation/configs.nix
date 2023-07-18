{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (inputs.cells.library.lib) list;
  inherit (__inputs__) std-data-collection;
  l = inputs.nixpkgs.lib // builtins;
  # a = f: list: l.pipe f (map (l.flip l.id) list);
  a = f: list: l.foldl' l.id f list;
  f = x: y: z: "${toString x}${toString y}${toString z}";
  xs = [1 2 3];
in {
  treefmt = let
    preset = inputs.cells.preset.configs.treefmt;
  in (
    std-data-collection.data.configs.treefmt
    preset.julia
    preset.rust
    preset.nvfetcher
    {
      packages = [
        # inputs.nixpkgs.nodePackages.prettier
        # inputs.nixpkgs.nodePackages.prettier-plugin-toml
        # inputs.nixpkgs.shfmt
      ];
      devshell.startup.prettier-plugin-toml =
        inputs.nixpkgs.lib.stringsWithDeps.noDepEntry
        ''
          export NODE_PATH=${inputs.nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:''${NODE_PATH-}
        '';
    }
  );
  conform = std-data-collection.data.configs.conform;
  # mdbook = std-data-collection.data.configs.mdbook {
  #   data = {
  #     book.title = "Cells Lab Doc";
  #   };
  # };
}
