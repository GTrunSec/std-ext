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
  nushell = nixpkgs.nushell.overrideAttrs (old: {
    cargoBuildFlags = ["--features" "dataframe"];
  });
  inherit (nixpkgs) nu-plugin-regex nu-plugin-from-parquet;
}
