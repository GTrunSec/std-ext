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
      context = builtins.concatStringsSep " " (
        lib.attrsets.mapAttrsToList (n: v: ''
          ${n} := `${toString v}`
          fmt.Print(glamour.Render(${n}, "dark"))
        '')
        attrs
      );
      main = nixpkgs.writeText "main.go" (import ./_packages/glamour-custom/main.nix {inherit context;});
    in {
      preConfigure = ''
        cp ${main} main.go
      '';
    });

  # the makeTemplate does not work with hcl to nomad
  makeTemplate = {
    name ? "makeTemplate",
    source,
    text ? "",
    format,
    searchPaths ? {bin = [];},
    target ? ["nomad" "docker-compose"],
  }:
    writeShellApplication {
      name = "makeTemplate";
      runtimeInputs = [nixpkgs.remarshal nixpkgs.yj nixpkgs.git nixpkgs.treefmt] ++ searchPaths.bin;
      text = let
        json = nixpkgs.writeText "JSON" (builtins.toJSON source);
        directory = builtins.replaceStrings ["-"] ["/"] name;
      in
        ''
          # <project>-<target>-<driver>-<branch>
          CELLSINFRAPATH="$PRJ_ROOT/cells-infra/${directory}"
          if [ ! -d "$CELLSINFRAPATH" ]; then
          mkdir -p "$CELLSINFRAPATH"
          fi

          ${nixpkgs.lib.optionalString (format == "yaml") ''
            json2yaml  -i ${json} -o "$CELLSINFRAPATH/${name}.yaml"
          ''}
          ${nixpkgs.lib.optionalString (format == "json") ''
            json2json -i ${json} -o "$CELLSINFRAPATH/${name}.json"
          ''}
          ${nixpkgs.lib.optionalString (target == "nomad") ''
            ${nixpkgs.nomad}/bin/nomad job plan "$CELLSINFRAPATH/${name}.json"
          ''}
          ${nixpkgs.lib.optionalString (target == "docker-compose") ''
            ${nixpkgs.docker-compose}/bin/docker-compose -f "$CELLSINFRAPATH/${name}.${format}" config -q
          ''}
        ''
        + text;
    };
in {
  inherit glamourTemplate makeTemplate;
}
