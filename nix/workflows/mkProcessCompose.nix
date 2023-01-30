{inputs}: cellBlocks: self: attrs: let
  l = inputs.nixpkgs.lib // builtins;
  inherit (inputs.cells.writers.lib) writeShellApplication writeConfig;

  cellTasks = cellBlock:
    l.pipe
    (
      l.mapAttrs (system:
        l.mapAttrs (user: blocks: (
          l.pipe blocks [
            (l.attrByPath [cellBlock] {})
            (l.filterAttrs (_: _: inputs.nixpkgs.system == system))
            (l.mapAttrs (name: value: {
              name = "//${user}/${cellBlock}/${name}";
              value = let
                extraAttrPath =
                  if l.hasAttr "extraAttrPath" value.process-compose
                  then value.process-compose.extraAttrPath
                  else [];
              in
                l.recursiveUpdate {
                  command = l.getExe (l.getAttrFromPath extraAttrPath value);
                  disabled = true;
                } (l.optionalAttrs (value ? process-compose)
                  (l.removeAttrs value.process-compose ["extraAttrPath"]));
            }))
          ]
        )))
      (l.intersectAttrs (l.genAttrs l.systems.doubles.all (_: null)) self)
    ) [
      (l.collect (x: x ? name && x ? value))
      l.listToAttrs
    ];
  composeYaml = writeConfig "compose.yaml" ({processes = l.foldr (a: b: a // b) {} (map (v: cellTasks v) cellBlocks);} // attrs);
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
