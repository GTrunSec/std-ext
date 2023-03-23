{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib) cfg;
in {
  lefthook = cfg.lefthook {data = cell.config.lefthook;};
  conform = cfg.conform {data = cell.config.conform;};
}
