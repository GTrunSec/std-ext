{
  makeSecretForEnvFromSops,
  makeScript,
  env,
  __nixpkgs__,
}: let
  secretsEnv = makeSecretForEnvFromSops {
    name = "makeSecretForEnvFromSops";
    inherit (env) vars manifest;
  };
in
  makeScript {
    entrypoint = "echo $hello";
    name = "secrets-for-gpg-from-env";
    searchPaths.bin = [__nixpkgs__.gnupg];
    searchPaths.source = [secretsEnv];
  }
