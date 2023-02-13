{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in
  builtins.mapAttrs (_: std.lib.dev.mkNixago) {
    example = {
      data = {
        description = ''
          https://cloudinit.readthedocs.io/en/latest/topics/examples.html
        '';
      };
      output = "test/schemas/cloud-init.json";
      format = "yaml";
      hook.mode = "copy";
    };
  }
