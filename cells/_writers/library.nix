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
    cliche.overridePythonAttrs (oldAttrs: let
      python =  inputs.nixpkgs.python3.withPackages ( ps: [
        cliche
        ]);
      in{
      pname = "cliche-" + name;
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [  ];
      postFixup = ''
      $out/bin/cliche install --module_dir ${dir} ${name}
      sed -i 's|#! /nix/store/.*.|#! ${python}/bin/python|' $out/bin/${name}
      '';
    });
in
{
  inherit writeClicheApplication;
}
