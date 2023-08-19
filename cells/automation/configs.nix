{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (inputs.cells.library.lib) list;
  l = inputs.nixpkgs.lib // builtins;
  # a = f: list: l.pipe f (map (l.flip l.id) list);
  a = f: list: l.foldl' l.id f list;
  f =
    x: y: z:
    "${toString x}${toString y}${toString z}";
  xs = [
    1
    2
    3
  ];
in
{
  treefmt =
    let
      presets = inputs.cells.presets.configs.treefmt;
    in
    (inputs.cells.presets.nixago.treefmt presets.julia
      # preset.rust
      presets.nvfetcher
    );
}
