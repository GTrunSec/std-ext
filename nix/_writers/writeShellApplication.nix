{
  inputs,
  cell,
}: {
  name,
  text,
  env ? {},
  runtimeInputs ? [],
  checkPhase ? null,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.nixpkgs) lib;
in
  nixpkgs.writeTextFile {
    inherit name;
    executable = true;
    destination = "/bin/${name}";
    text = ''
      #!${nixpkgs.runtimeShell}
      set -o errexit
      set -o nounset
      set -o pipefail
      export PATH="${lib.makeBinPath runtimeInputs}:$PATH"
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
        ${nixpkgs.stdenv.shell} -n $out/bin/${name}
        ${nixpkgs.shellcheck}/bin/shellcheck $out/bin/${name}
        runHook postCheck
      ''
      else checkPhase;
    meta.mainProgram = name;
  }
