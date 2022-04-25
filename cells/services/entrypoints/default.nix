{
  inputs,
  cell,
} @ args: let
  inherit (inputs.cells._lib.library.lib) pathsToImportedNestedAttrs;
  lib =
    (inputs.nixpkgs.appendOverlays [
      (_final: prev: {
        lib = prev.lib.extend (import ../../_lib/extend.nix);
      })
    ])
    .lib;
in
  {
  }
  // (lib.pathsToImportedNestedAttrs [
      ./nomad-container-elk
      ./nomad-nixos-airflow
      ./nomad-nixos-waterwheel
      ./nomad-container-traefik
    ]
    args)
