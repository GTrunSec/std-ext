nixpkgs:
# credit: https://github.com/srid/monorepo-nix-template/blob/master/nix/mergeDevShells.nix
# Merge multiple devShells into one, such that entering the resulting
# dev shell puts one in the environment of all the input dev shells.
envs: let
  l = nixpkgs.lib // builtins;
in
  nixpkgs.mkShell (builtins.foldl'
    (
      a: b:
      # Standard shell attributes
        {
          buildInputs = (a.buildInputs or []) ++ (b.buildInputs or []);
          nativeBuildInputs = (a.nativeBuildInputs or []) ++ (b.nativeBuildInputs or []);
          propagatedBuildInputs = (a.propagatedBuildInputs or []) ++ (b.propagatedBuildInputs or []);
          propagatedNativeBuildInputs = (a.propagatedNativeBuildInputs or []) ++ (b.propagatedNativeBuildInputs or []);
          shellHook = (a.shellHook or "") + "\n" + (b.shellHook or "");
        }
        //
        # Environment variables
        (
          let
            isUpperCase = s: l.strings.toUpper s == s;
            filterUpperCaseAttrs = attrs: l.attrsets.filterAttrs (n: _: isUpperCase n) attrs;
          in
            filterUpperCaseAttrs a // filterUpperCaseAttrs b
        )
    )
    (nixpkgs.mkShell {})
    (l.attrsets.attrValues envs))
