{
  config,
  lib,
  pkgs,
  inputs,
  writeShellApplication,
  ...
}: {
  config.templates = {
    configuration = let
      cfg = config.templates;
      format = lib.last (lib.splitString "." cfg.name);
    in
      writeShellApplication {
        name = "configuration";
        runtimeInputs = [pkgs.remarshal pkgs.yj] ++ cfg.searchPaths.bin;
        text = let
          json = pkgs.writeText "JSON" (builtins.toJSON cfg.source);
          directory = builtins.replaceStrings ["-"] ["/"] cfg.name + "/" + cfg.branch;
          writeSource = lib.concatStringsSep "\n" (map (f: ''
              cp ${f} "$CELLSINFRAPATH/${builtins.baseNameOf f}"
              chmod +rw "$CELLSINFRAPATH/${builtins.baseNameOf f}"
            '')
            cfg.searchPaths.file);

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

            ${pkgs.lib.optionalString (format == "yaml") ''
              json2yaml  -i ${json} -o "$CELLSINFRAPATH/${cfg.name}"
            ''}
            ${pkgs.lib.optionalString (format == "json") ''
              json2json -i ${json} -o "$CELLSINFRAPATH/${cfg.name}"
            ''}
            ${pkgs.lib.optionalString (cfg.target == "terraform") ''
              cp ${cfg.source} "$CELLSINFRAPATH/config.tf.json"
              chmod +rw "$CELLSINFRAPATH/config.tf.json"
            ''}
            ${pkgs.lib.optionalString (cfg.target == "nomad") ''
              ${inputs.cells.hashicorp.packages.nomad}/bin/nomad job plan "$CELLSINFRAPATH/${cfg.name}"
            ''}
            ${pkgs.lib.optionalString (cfg.target == "docker-compose") ''
              ${pkgs.docker-compose}/bin/docker-compose -f "$CELLSINFRAPATH/${cfg.name}" config -q
            ''}
          ''
          + cfg.text
          + (
            if cfg.searchPaths.file != []
            then "${writeSource}"
            else ""
          );
      };
  };
}
