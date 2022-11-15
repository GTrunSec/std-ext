{
  inputs,
  cell,
}: {
  name,
  path,
  env ? {},
  runtimeInputs ? [],
  libraries ? [],
  checkPhase ? null,
}: let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs) nixpkgs;
  python = inputs.nixpkgs.python3.withPackages (
    _ps: [
      cell.packages.cliche
      libraries
    ]
  );
in
  nixpkgs.stdenvNoCC.mkDerivation {
    inherit name;
    buildInputs = runtimeInputs ++ [python];
    src = path;
    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cliche install --module_dir ${path} $out/bin/${name}
      sed -i 's|#! /nix/store/.*.|#! ${python}/bin/python|' $out/bin/${name}
      sed -i 's|{{runtimeInputs}}|${lib.makeBinPath runtimeInputs}|' $out/bin/${name}
      sed -i "14 i time.sleep(os.environ.get('DEBUG_SLEEP', 0))\n\
      ${
        builtins.concatStringsSep "\n" (
          lib.attrsets.mapAttrsToList (n: v: "os.environ['${n}'] = os.environ.get('${n}', '${v}')")
          env
        )
      }" $out/bin/${name}

      runHook postInstall
    '';
    checkPhase =
      if checkPhase == null
      then ''
        runHook preCheck
        for path in $(find "${path}" -name '*.py')
        do
           ${nixpkgs.python3Packages.black}/bin/black --check $path
        done
        export HOME=$(mktemp -d)
        $out/bin/${name} --help
        runHook postCheck
      ''
      else checkPhase;
    meta.mainProgram = name;
  }
