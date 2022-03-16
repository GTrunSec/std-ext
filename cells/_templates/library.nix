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
  attrConvertTemplate = args:
    writeShellApplication {
      name = "attrConvert";
      runtimeInputs = [nixpkgs.remarshal nixpkgs.json2hcl];
      text = let
        json = nixpkgs.writeText "JSON" (builtins.toJSON args.source);
      in ''
        ${nixpkgs.lib.optionalString (args.format == "yaml") ''
          json2yaml  -i ${json} -o "$@"
        ''}
         ${nixpkgs.lib.optionalString (args.format == "hcl") ''
          json2hcl < ${json} > "$@"
        ''}
      '';
    };
in {
  inherit glamourTemplate attrConvertTemplate;
}
