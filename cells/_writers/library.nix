{ inputs
, system
}:
let
  nixpkgs = inputs.nixpkgs;
  lib = inputs.nixpkgs.lib;
  stdenv = inputs.nixpkgs.stdenv;
  writeTextFile = inputs.nixpkgs.writeTextFile;
  runtimeShell = inputs.nixpkgs.runtimeShell;
  cliche = inputs.nixpkgs.python3Packages.callPackage ./packages/cliche.nix { };
  writeClicheApplication =
    { name
    , dir
    , env ? { }
    , runtimeInputs ? [ ]
    , libraries ? [ ]
    , checkPhase ? null
    }:
      cliche.overridePythonAttrs (
        oldAttrs: let
          python = inputs.nixpkgs.python3.withPackages (
            ps: [
              cliche
              libraries
            ]
          );
        in
          {
            pname = name;
            propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ runtimeInputs;
            checkPhase =
              if checkPhase == null
              then
          ''
            runHook preCheck
            for path in $(find "${dir}" -name '*.py')
            do
               ${nixpkgs.python3Packages.black}/bin/black --check $path
            done
            runHook postCheck
          ''
        else checkPhase;
            postFixup = ''
              $out/bin/cliche install --module_dir ${dir} ${name}
              sed -i 's|#! /nix/store/.*.|#! ${python}/bin/python|' $out/bin/${name}
              sed -i 's|{{runtimeInputs}}|${lib.makeBinPath runtimeInputs}|' $out/bin/${name}
              rm -rf $out/bin/cliche
            '';
          }
      );
in
{
  inherit writeClicheApplication;
}
