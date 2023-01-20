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
              value = l.recursiveUpdate {
                command = l.getExe value;
                disabled = true;
              } (l.optionalAttrs (value ? process-compose) value.process-compose);
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
