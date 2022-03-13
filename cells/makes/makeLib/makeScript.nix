{
  makeEnvVars,
  makeScript,
  __nixpkgs__,
}:
{
  name,
  text,
  searchPaths,
  __output__,
}:
let
  makeEnvVarsOutput = (mapping:
    makeEnvVars {
      name = "makeEnvVarsOutput";
      inherit mapping;
    }) __output__;
in
  makeScript (__nixpkgs__.lib.recursiveUpdate{
    entrypoint = text;
    inherit name;
    inherit searchPaths;
  } {
    searchPaths.source = [ makeEnvVarsOutput ];
  })
