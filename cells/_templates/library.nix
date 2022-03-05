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
    (inputs)
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
  nickelTemplate = {
    name,
    # enum [ "json" "yaml" "toml" "raw"]
    format ? "json",
    args ? [],
    file,
    target ? "nomad",
  }:
    writeShellApplication {
      inherit name;
      runtimeInputs = [packages.nickel-nickel];
      text = let
        command = "nickel -f ${builtins.toPath file} export --format ${format}";
      in ''
        ${command}
        ${
          lib.optionalString (target == "nomad") ''
            ${command}| ${nixpkgs.nomad}/bin/nomad job validate -
          ''
        }
      '';
    };
in {
  inherit nickelTemplate glamourTemplate;
}
