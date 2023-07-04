{
  makeEnvVars,
  makeScript,
  __nixpkgs__,
}: {
  name ? "makeScript",
  entrypoint ? "",
  searchPaths,
  env,
}: let
  makeEnvVarsOutput = (mapping:
    makeEnvVars {
      name = "makeEnvVarsOutput";
      inherit mapping;
    })
  env;
in
  makeScript (__nixpkgs__.lib.recursiveUpdate {
      inherit name searchPaths entrypoint;
    } {
      searchPaths.source = [makeEnvVarsOutput];
    })
