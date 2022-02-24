{
  inputs,
  system,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.nixpkgs-hardenedlinux.inputs.gomod2nix.overlay
  ];

  lib = inputs.nixpkgs.lib;
  library = inputs.self.library.${system.build.system};
  nickel = inputs.nickel.defaultPackage.${system.host.system};

  glamour-coustom = nixpkgs.callPackage ./_packages/glamour-custom {};

  writeShellApplication = library._writers-writeShellApplication;

  glamourTemplate = {...} @ attrs:
    glamour-coustom.overrideAttrs (old: let
      context =
        builtins.concatStringsSep "\n" (
          lib.attrsets.mapAttrsToList (n: v: "${n} := `${toString v}`")
          attrs
        );
      main = nixpkgs.writeText "main.go" (import ./_packages/glamour-custom/main.nix {inherit context;});
    in {
      preConfigure = ''
       cp ${main} main.go
      '';
      # installPhase = ''
      #   runHook preInstall
      #   mkdir -p $out/bin
      #   mv main $out/bin/glamour-custom
      #   cp ${main} $out/bin/
      #   runHook postInstall
      # '';
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
      runtimeInputs = [nickel];
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
