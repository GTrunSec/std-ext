{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (__inputs__) std-data-collection;
  l = inputs.nixpkgs.lib // builtins;

  # a = f: list: l.pipe f (map (l.flip l.id) list);
  a = f: list: l.foldl' l.id f list;
  f = x: y: z: "${toString x}${toString y}${toString z}";
  xs = [1 2 3];
in {
}
