{
  inputs,
  cell,
}: let
  inherit (inputs) std nixpkgs data-merge;
in
  builtins.mapAttrs (_: std.std.lib.mkNixago) {
    example = {
      configData = {
        description = ''
          https://cloudinit.readthedocs.io/en/latest/topics/examples.html
        '';
      };
      output = "test/schemas/phishing-url-jsonschema.yaml";
      format = "yaml";
      hook.mode = "copy";
    };
  }
