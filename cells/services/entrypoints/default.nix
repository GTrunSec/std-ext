{
  inputs,
  cell,
} @ args: let
  lib =
    (inputs.nixpkgs.appendOverlays [
      (_final: prev: {
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
