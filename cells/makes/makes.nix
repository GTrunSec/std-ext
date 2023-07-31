{ inputs }:
let
  __inputs__ = import ./.;
in
{
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
    vast = {
      __argAggregate__ =
        builtins.readFile
          "${__inputs__.inputs.vast}/plugins/aggregate/README.md";
    };
  };
  secretsForEnvFromSops = {
    cloudflare = {
      manifest = "/secrets/secrets.yaml";
      vars = [
        "CLOUDFLARE_ACCOUNT_ID"
        "CLOUDFLARE_API_TOKEN"
      ];
    };
    example = {
      manifest = ../secrets/secrets-opencti.yaml;
      vars = [
        "OPENCTI_ADMIN_EMAIL"
        "OPENCTI_ADMIN_PASSWORD"
      ];
    };
  };
}
