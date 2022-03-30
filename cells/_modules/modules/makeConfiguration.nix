{
  config,
  lib,
  pkgs,
  writeShellApplication,
  inputs,
  ...
}: {
  config.templates = {
    makeConfiguration = let
      cfg = config.templates;
    in
      writeShellApplication {
        name = "makeConfiguration";
        runtimeInputs = [pkgs.remarshal pkgs.yj] ++ cfg.searchPaths.bin;
        text = let
          json = pkgs.writeText "JSON" (builtins.toJSON cfg.source);
          directory = builtins.replaceStrings ["-"] ["/"] cfg.name + "/" + cfg.branch;
          writeSource = lib.concatStringsSep "\n" (map (f: ''
              cp ${f} "$CELLSINFRAPATH/${builtins.baseNameOf f}"
              chmod +rw "$CELLSINFRAPATH/${builtins.baseNameOf f}"
            '')
            cfg.searchPaths.source);

          CELLSINFRAPATH =
            if cfg.path == null
            then "$PRJ_ROOT/cells-infra/infra/${directory}"
            else cfg.path;
        in
          ''
            # <project>-<target>-<driver>-<branch>
            CELLSINFRAPATH="${CELLSINFRAPATH}"
            if [ ! -d "$CELLSINFRAPATH" ]; then
            mkdir -p "$CELLSINFRAPATH"
            fi

            ${pkgs.lib.optionalString (cfg.format == "yaml") ''
              json2yaml  -i ${json} -o "$CELLSINFRAPATH/${cfg.name}.yaml"
            ''}
            ${pkgs.lib.optionalString (cfg.format == "json") ''
              json2json -i ${json} -o "$CELLSINFRAPATH/${cfg.name}.json"
            ''}
            ${pkgs.lib.optionalString (cfg.target == "terraform") ''
              cp ${cfg.source} "$CELLSINFRAPATH/config.tf.json"
              chmod +rw "$CELLSINFRAPATH/config.tf.json"
            ''}
            ${pkgs.lib.optionalString (cfg.target == "nomad") ''
              ${pkgs.nomad}/bin/nomad job plan "$CELLSINFRAPATH/${cfg.name}.json"
            ''}
            ${pkgs.lib.optionalString (cfg.target == "docker-compose") ''
              ${pkgs.docker-compose}/bin/docker-compose -f "$CELLSINFRAPATH/${cfg.name}.${cfg.format}" config -q
            ''}
          ''
          + cfg.text
          + (
            if cfg.searchPaths.source != []
            then "${writeSource}"
            else ""
          );
      };
  };
}
