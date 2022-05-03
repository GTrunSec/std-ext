{
  inputs,
  cell,
}: {
  name ? "",
  language ? "nix",
  runtimeInputs ? [],
  args ? [],
  source ? "",
  format ? "json",
  target ? "nomad",
  text ? "",
}: let
  inherit (cell) library;
  inherit (inputs.nixpkgs) lib;
  inherit (inputs) cells nixpkgs;
in
  library.writeShellApplication {
    inherit name;
    runtimeInputs =
      lib.optionals (language == "nickel") [cells.makeConfiguration.packages.nickel]
      ++ lib.optionals (language == "cue") [nixpkgs.cue]
      ++ lib.optionals (language == "nix") []
      ++ runtimeInputs ++ [ nixpkgs.bat ];
    text = let
      json = nixpkgs.writeText "JSON" (builtins.toJSON source);
      command =
        lib.concatStringsSep " " ((lib.optionals (language == "nickel")
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
        ++ (lib.optionals (language == "nix") [
          "cat"
          "<"
          "${json}"
          ]));
    in ''
      ${command} | bat --theme ansi --file-name ${name}.${format} --paging=never
      ${
        lib.optionalString (target == "nomad") ''
          ${command} | ${nixpkgs.nomad}/bin/nomad job validate -
        ''
      }
      ${text}
    '';
  }
