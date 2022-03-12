{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.nixpkgs-hardenedlinux.inputs.gomod2nix.overlay
  ];

  inherit
    (nixpkgs)
    lib
    ;
  inherit
    (inputs.self)
    packages
    ;
  inherit (inputs.cells._writers.library) writeShellApplication;

  glamour-coustom = nixpkgs.callPackage ./_packages/glamour-custom {};

  glamourTemplate = {...} @ attrs:
    glamour-coustom.overrideAttrs (old: let
      context = builtins.concatStringsSep "\n" (
        lib.attrsets.mapAttrsToList (n: v: "${n} := `${toString v}`")
        attrs
      );
      main = nixpkgs.writeText "main.go" (import ./_packages/glamour-custom/main.nix {inherit context;});
    in {
      preConfigure = ''
        cp ${main} main.go
      '';
    });
in {
  inherit glamourTemplate;
}
