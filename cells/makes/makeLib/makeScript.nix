{
  makeEnvVars,
  makeScript,
  __nixpkgs__,
}: {
  name ? "makeScript",
  text,
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
      entrypoint = text;
      inherit name;
      inherit searchPaths;
    } {
      searchPaths.source = [makeEnvVarsOutput];
    })
