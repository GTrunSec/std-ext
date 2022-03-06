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
  makeTemplate = {
    name,
    # enum [ "json" "yaml" "toml" "raw"]
    language ? "nickel",
    format ? "json",
    args ? [],
    path,
    target ? "nomad",
  }: let
    isNickel =
      if language == "nickel"
      then true
      else false;
    isCue =
      if language == "cue"
      then true
      else false;
    isTerranix =
      if language == "terranix"
      then true
      else false;
  in
    writeShellApplication {
      inherit name;
      runtimeInputs =
        lib.optionals isNickel [packages.templates-nickel]
        ++ lib.optionals isCue [nixpkgs.cue]
        ++ lib.optionals isTerranix [];
      text = let
        command = lib.removeSuffix "\n\n\n\n" ''
          ${lib.optionalString isNickel ''
            nickel -f ${path}/${builtins.concatStringsSep " " args} export --format ${format}
          ''}
          ${lib.optionalString isCue "
            cue export ./${path} -e ${builtins.concatStringsSep " " args} --out=${format}
          "}
          ${lib.optionalString isTerranix "
            cue export ./${path} -e ${builtins.concatStringsSep " " args} --out=${format}
          "}
        '';
      in ''
        ${command}
        ${
          lib.optionalString (target == "nomad") ''
            ${command} | ${nixpkgs.nomad}/bin/nomad job validate -
          ''
        }
      '';
    };
in {
  inherit makeTemplate glamourTemplate;
}
