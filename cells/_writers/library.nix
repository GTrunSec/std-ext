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
    stdenv
    writeTextFile
    runtimeShell
    shellcheck
    glibcLocales
    python3Packages
    ;
  cliche = python3Packages.callPackage ./_packages/cliche {};

  writeClicheApplication = {
    name,
    path,
    env ? {},
    runtimeInputs ? [],
    libraries ? [],
    checkPhase ? null,
  }: let
    python = inputs.nixpkgs.python3.withPackages (
      ps: [
        cliche
        libraries
      ]
    );
  in
    nixpkgs.stdenvNoCC.mkDerivation {
      inherit name;
      buildInputs = runtimeInputs;
      src = path;
      installPhase = ''
        runHook preInstall

        mkdir -p $out/bin
        cp ${cliche}/bin/hello $out/bin/${name}
        sed -i 's|#! /nix/store/.*.|#! ${python}/bin/python|' $out/bin/${name}
        sed -i 's|{{runtimeInputs}}|${lib.makeBinPath runtimeInputs}|' $out/bin/${name}

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
    };
  # cliche.overridePythonAttrs (
  #   oldAttrs: let
  #     python = inputs.nixpkgs.python3.withPackages (
  #       ps: [
  #         cliche
  #         libraries
  #       ]
  #     );
  #   in {
  #     pname = name;
  #     propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ runtimeInputs;
  #     postFixup = ''
  #       $out/bin/cliche install --module_dir ${path} ${name}
  #       sed -i 's|#! /nix/store/.*.|#! ${python}/bin/python|' $out/bin/${name}
  #       sed -i 's|{{runtimeInputs}}|${lib.makeBinPath runtimeInputs}|' $out/bin/${name}
  #       rm -rf $out/bin/cliche
  #     '';
  #     checkPhase =
  #       if checkPhase == null
  #       then ''
  #         runHook preCheck
  #         for path in $(find "${path}" -name '*.py')
  #         do
  #            ${nixpkgs.python3Packages.black}/bin/black --check $path
  #         done
  #         export HOME=$(mktemp -d)
  #         $out/bin/${name} --help
  #         runHook postCheck
  #       ''
  #       else checkPhase;

  #     meta.mainProgram = name;
  #   }
  # );

  writeShellApplication = {
    name,
    text,
    env ? {},
    runtimeInputs ? [],
    checkPhase ? null,
  }:
    writeTextFile {
      inherit name;
      executable = true;
      destination = "/bin/${name}";
      text = ''
        #!${runtimeShell}
        set -o errexit
        set -o nounset
        set -o pipefail
        export PATH="${lib.makeBinPath runtimeInputs}:$PATH"
        # TODO: cleanup after https://github.com/divnix/std/issues/27
        ${
          builtins.concatStringsSep "\n" (
            lib.attrsets.mapAttrsToList (n: v: "declare ${n}=${''"$''}{${n}:-${toString v}}${''"''}")
            env
          )
        }
        ${text}
      '';
      checkPhase =
        if checkPhase == null
        then ''
          runHook preCheck
          ${stdenv.shell} -n $out/bin/${name}
          ${shellcheck}/bin/shellcheck $out/bin/${name}
          runHook postCheck
        ''
        else checkPhase;
      meta.mainProgram = name;
    };

  writePiplelineApplication = {
    name,
    julia ? nixpkgs.julia_17-bin,
    path ? "",
    args ? [],
    env ? {},
    threads ? 8,
    runtimeInputs ? [],
  }:
    writeShellApplication {
      inherit name env;
      runtimeInputs = [nixpkgs.julia_17-bin] ++ runtimeInputs;
      text = ''
        manifest=$CELL_ROOT/_writers/_packages/jobSchedulers
        julia -e "import Pkg; Pkg.activate(\"$manifest\"); Pkg.instantiate();" -L ${path}/${builtins.concatStringsSep " " args} --threads ${threads} "$@"
      '';
    };

  writeComoniconApplication = {
    name,
    julia ? nixpkgs.julia_17-bin,
    path ? "",
    args ? [],
    env ? {},
    threads ? 8,
    runtimeInputs ? [],
  }:
    writeShellApplication {
      inherit name env;
      runtimeInputs = [nixpkgs.julia_17-bin] ++ runtimeInputs;
      text = ''
        manifest=$CELL_ROOT/_writers/_packages/comonicon
        julia -e "import Pkg; Pkg.activate(\"$manifest\"); Pkg.instantiate();" -L ${path}/${builtins.concatStringsSep " " args} --threads ${threads} "$@"
      '';
    };
in {
  inherit writeClicheApplication writePiplelineApplication writeComoniconApplication;
  writeShellApplication = {...} @ args:
    writeShellApplication (
      args
      // {
        text = ''
          export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
          ${args.text}
        '';
      }
    );
}
