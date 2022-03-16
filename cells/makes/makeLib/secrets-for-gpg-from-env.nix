{
  makeSecretForEnvFromSops,
  makeScript,
  __nixpkgs__,
}: {
  text,
  name ? "secrets-for-gpg-from-env",
  env,
  searchPaths,
}: let
  secretsEnv = makeSecretForEnvFromSops {
    name = "makeSecretForEnvFromSops";
    inherit (env) vars manifest;
  };
in
  makeScript (__nixpkgs__.lib.recursiveUpdate {
      entrypoint = text;
      inherit name;
      inherit searchPaths;
    } {
      searchPaths.bin = [__nixpkgs__.gnupg];
      searchPaths.source = [secretsEnv];
    })
