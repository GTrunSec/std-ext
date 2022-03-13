{...}: {
  envVars = {
    example = {
      a = "1";
      b = "2";
      VAR_NAME = "test";
    };
  };
  documents = {
    makes = {
      __argPath__ = builtins.readFile ../doc/test.md;
    };
  };
  secretsForEnvFromSops = {
    cloudflare = {
      manifest = "/secrets/secrets.yaml";
      vars = ["CLOUDFLARE_ACCOUNT_ID" "CLOUDFLARE_API_TOKEN"];
    };
    example = {
      manifest = ../secrets/secrets.yaml;
      vars = ["hello"];
    };
  };
}
