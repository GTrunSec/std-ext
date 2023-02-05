{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib.ops) mkOperable mkStandardOCI;
in {
  inherit mkStandardOCI;
  mkOperable = {...} @ args:
    mkOperable (
      args
      // {
        runtimeScript = ''
          set +m
          ${args.runtimeScript}
        '';
      }
    );
}
