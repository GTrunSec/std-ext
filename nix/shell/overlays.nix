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
    nushell-latest = prev.callPackage ./packages/nushell.nix {
      AppKit = prev.darwin.apple_sdk.frameworks.AppKit;
      Libsystem = prev.darwin.apple_sdk.frameworks.Libsystem;
      Security = prev.darwin.apple_sdk.frameworks.Security;
    };
  };
}
