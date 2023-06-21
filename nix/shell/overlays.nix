{
  inputs,
  cell,
}: let
in {
  default = final: prev: let
    mkNushellPlugin = prev.callPackage ./packages/mkNuShellPlugin.nix {};
  in {
    shell-sources = prev.callPackage ./packages/_sources/generated.nix {};
    nu-plugin-regex = mkNushellPlugin "nu-plugin-regex";
    nu-plugin-from-parquet = mkNushellPlugin "nu-plugin-from-parquet";
  };
}
