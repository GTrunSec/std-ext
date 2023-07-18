{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib.dev) mkNixago;
  inherit (inputs.std.lib) cfg;
in {
  treefmt = (mkNixago cfg.treefmt) cell.configs.treefmt.default;
}
