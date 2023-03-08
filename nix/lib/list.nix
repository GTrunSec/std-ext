{
  inputs,
  cell,
}: let
  l = inputs.nixlib.lib // builtins;
  inherit (l) filter;
in rec {
  # filters out empty strings and null objects from a list
  filterListNonEmpty = l: (filter (x: (x != "" && x != null)) l);
}
