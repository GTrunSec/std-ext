{
  makeSecretForEnvFromSops,
  makeScript,
  __nixpkgs__,
}: let
  secretsForEnvFromSops = {
    cloudflare = {
      manifest = "/secrets/secrets.yaml";
      vars = ["CLOUDFLARE_ACCOUNT_ID" "CLOUDFLARE_API_TOKEN"];
    };
    example = {
      manifest = ../../../secrets/secrets.yaml;
      vars = ["hello"];
    };
  };
  secretsEnv = makeSecretForEnvFromSops {
    name = "tests-secrets-for-gpg-from-env";
    inherit (secretsForEnvFromSops.example) vars manifest;
  };
in
  makeScript {
    entrypoint = "echo $hello";
    name = "secrets-for-gpg-from-env";
    searchPaths.bin = [__nixpkgs__.gnupg];
    searchPaths.source = [
      secretsEnv
    ];
  }
