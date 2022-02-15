{ inputs
, system
}:
let
  nixpkgs = inputs.nixpkgs;
  lib = inputs.nixpkgs.lib;
  stdenv = inputs.nixpkgs.stdenv;
  writeTextFile = inputs.nixpkgs.writeTextFile;
  runtimeShell = inputs.nixpkgs.runtimeShell;
  cliche = inputs.nixpkgs.python3Packages.callPackage ./cliche.nix {};
  writeClicheApplication =
    { name
    , dir
    , env ? { }
    , runtimeInputs ? [ ]
    , libraries ? [ ]
    , checkPhase ? null
    }:
    cliche.overridePythonAttrs (oldAttrs: {
      pname = "cliche" + name;
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [  ];
      postFixup = ''
      $out/bin/cliche install --module_dir ${dir} ${name}
      sed -i 's|#! /nix/store/.*.|#!/home/gtrun/ghq/github.com/GTrunSec/DevSecOps-cells/cells/cliche/.venv/bin/python|' $out/bin/${name}
      # the cache file will be in $HOME/.cache/cliche
      sed -i 's|/nix/store/.*./bin/exmaple-cliche.json|/.cache/cliche/${name}.json|' $out/bin/${name}
      '';
    });
in
{
  inherit writeClicheApplication;
}
