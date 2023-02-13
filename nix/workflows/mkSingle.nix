{inputs}: attrs: let
  l = inputs.nixpkgs.lib // builtins;
  inherit (inputs.cells.writers.lib) writeShellApplication writeConfig;

  tasks = (l.mapAttrs (name: value:
    if value ? process-compose
    then {
      inherit name;
      value = let
        extraAttrPath =
          if l.hasAttr "extraAttrPath" value.process-compose
          then value.process-compose.extraAttrPath
          else [];
      in
        l.recursiveUpdate {
          command = l.getExe (l.getAttrFromPath extraAttrPath value);
        } (l.optionalAttrs (value ? process-compose)
          (l.removeAttrs value.process-compose ["extraAttrPath"]));
    }
    else {}))
  attrs;

  composeYaml = writeConfig "compose.yaml" {processes = tasks;};
in
  (writeShellApplication {
    name = "process-compose";
    runtimeInputs = [inputs.cells.workflows.packages.process-compose];
    text = ''
      process-compose -f ${composeYaml} "$@"
    '';
  })
  .overrideAttrs (old: {
    passthru = {
      config = composeYaml;
    };
  })
