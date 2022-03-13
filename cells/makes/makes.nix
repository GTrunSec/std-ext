{...}: {
  envVars = {
    example = {
      a = "1";
      b = "2";
      VAR_NAME = "test";
    };
  };
  secretsForEnvFromSops = {
    cloudflare = {
      # Manifest contains inside:
      #   CLOUDFLARE_ACCOUNT_ID: ... ciphertext ...
      #   CLOUDFLARE_API_TOKEN: ... ciphertext ...
      manifest = "/secrets/secrets.yaml";
      vars = ["CLOUDFLARE_ACCOUNT_ID" "CLOUDFLARE_API_TOKEN"];
    };
    example = {
      manifest = ../secrets/secrets.yaml;
      vars = ["hello"];
    };
  };
}
