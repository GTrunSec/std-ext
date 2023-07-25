{
  makeEnvVars,
  makeScript,
  __nixpkgs__,
  lib,
}: {
  name ? "makeScript",
  entrypoint ? "",
  searchPaths ? {},
  env ? {},
}: let
  inherit (lib.attrsets) recursiveMerge;
  makeEnvVarsOutput = (mapping:
    makeEnvVars {
      name = "makeEnvVarsOutput";
      inherit mapping;
    })
  env;
in
  makeScript (recursiveMerge [
    {
      inherit name searchPaths entrypoint;
    }
    {
      searchPaths.source = [makeEnvVarsOutput];
    }
  ])
