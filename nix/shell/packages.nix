{
  inputs,
  cell,
}: let
  inherit (cell.lib) nixpkgs;
  inherit (inputs.cells.common.lib.__inputs__) nixpkgs-hardenedlinux;
in {
  inherit
    (nixpkgs-hardenedlinux.packages)
    tuc
    zed
    ;
  nushell-latest = nixpkgs.nushell-latest.overrideAttrs (old: {
    cargoBuildFlags = ["--features" "dataframe"];
  });
  inherit (nixpkgs) nu-plugin-regex nu-plugin-from-parquet;
}
