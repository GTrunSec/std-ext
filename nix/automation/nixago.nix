{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (inputs.cells.library.lib) list;
  inherit (__inputs__) std-data-collection;
  l = inputs.nixpkgs.lib // builtins;
in {
  treefmt = let
    preset = inputs.cells.preset.configs.treefmt;
  in
    list.foldFunction std-data-collection.data.configs.treefmt
    [
      preset.julia
      preset.rust
      preset.nvfetcher
    ];

  conform = std-data-collection.data.configs.conform;

  # mdbook = std-data-collection.data.configs.mdbook {
  #   data = {
  #     book.title = "Cells Lab Doc";
  #   };
  # };
}
