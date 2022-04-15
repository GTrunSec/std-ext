{
  inputs,
  cell,
} @ args: let
  inherit (inputs.cells._lib) library;
  lib =
    (inputs.nixpkgs.appendOverlays [
      (final: prev: {
        lib = prev.lib.extend (import ../../_lib/extend.nix);
      })
    ])
    .lib;
in
  {}
  // (lib.pathsToImportedNestedAttrs [
      ./nomad-container-elk
      ./nomad-nixos-airflow
    ]
    args)
