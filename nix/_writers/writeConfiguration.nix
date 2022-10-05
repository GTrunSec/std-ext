{
  inputs,
  cell,
}: {
  name ? "",
  language ? "nix",
  runtimeInputs ? [],
  args ? [],
  source ? {},
  format ? "json",
  target ? "",
  text ? "",
}: let
  inherit (cell) lib;
  inherit (inputs.nixpkgs) lib;
  inherit (inputs) cells nixpkgs;
  json =
    if target == "terraform"
    then (builtins.toJSON source)
    else builtins.toFile "${name}.json" (builtins.toJSON source);

  writeSource = let
    xml = builtins.toXML source;
  in
    nixpkgs.runCommand "${name}.${format}" {
      preferLocalBuild = true;
      buildInputs = [nixpkgs.remarshal];
    } ''
      ${nixpkgs.lib.optionalString (format == "json") ''
        cp ${json} $out
      ''}
      ${nixpkgs.lib.optionalString (format == "yaml") ''
        json2yaml -i ${json} -o $out
      ''}
        ${nixpkgs.lib.optionalString (format == "toml") ''
        json2toml -i ${json} -o $out
      ''}
      ${nixpkgs.lib.optionalString (format == "xml") ''
        cp ${xml} $out
      ''}
    '';
in
  (lib.writeShellApplication {
    inherit name;
    runtimeInputs =
      lib.optionals (language == "nickel") [cells.makeConfiguration.packages.nickel]
      ++ lib.optionals (language == "cue") [nixpkgs.cue]
      ++ lib.optionals (language == "nix") []
      ++ runtimeInputs
      ++ [nixpkgs.bat];
    text = let
      command = lib.concatStringsSep " " (
        (lib.optionals (language == "nickel")
          [
            "nickel"
            "-f"
            "${source}/${builtins.concatStringsSep " " args}"
            "export"
            "--format"
            "${format}"
          ])
        ++ (lib.optionals (language == "cue") [
          "cue"
          "export"
          "${source}"
          "-e"
          "${builtins.concatStringsSep " " args}"
          "--out=${format}"
        ])
        ++ (lib.optionals (language == "nix" && source != {}) [
          "cat"
          "<"
          "${writeSource}"
        ])
      );
    in ''
         ${
        lib.optionalString (command != "") ''
          ${command} | bat --theme ansi --file-name "${writeSource.out}" --paging=never
        ''
      }

      ${
        lib.optionalString (target == "nomad") ''
          ${command} | ${nixpkgs.nomad}/bin/nomad job validate -
        ''
      }
      ${text}
    '';
  })
  .overrideAttrs (old: {
    passthru.data = writeSource;
  })
