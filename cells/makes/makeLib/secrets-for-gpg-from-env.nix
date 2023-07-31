{
  makeSecretForEnvFromSops,
  makeScript,
  __nixpkgs__,
}:
{
  entrypoint,
  name ? "secrets-for-gpg-from-env",
  env,
  searchPaths,
}:
let
  secretsEnv = makeSecretForEnvFromSops {
    name = "makeSecretForEnvFromSops";
    inherit (env) vars manifest;
  };
in
makeScript (
  __nixpkgs__.lib.recursiveUpdate { inherit name searchPaths entrypoint; } {
    searchPaths.bin = [ __nixpkgs__.gnupg ];
    searchPaths.source = [ secretsEnv ];
  }
)
