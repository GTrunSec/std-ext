{
  inputs,
  system,
}: let
  nixpkgs = inputs.nixpkgs;
  lib = inputs.nixpkgs.lib;
  nickel = inputs.nickel.defaultPackage.${system.host.system};
  library = inputs.self.library.${system.build.system};
  writeShellApplication = library._writers-writeShellApplication;
  nickelTemplate = {
    name,
    # enum [ "json" "yaml" "toml" "raw"]
    format ? "json",
    args ? [],
    file,
    target ? "nomad",
  }:
    writeShellApplication {
      inherit name;
      runtimeInputs = [nickel];
      text = let
        command = "nickel -f ${builtins.toPath file} export --format ${format}";
      in ''
        ${command}
        ${
          lib.optionalString (target == "nomad") ''
            ${command}| ${nixpkgs.nomad}/bin/nomad job validate -
          ''
        }
      '';
    };
in {
  inherit nickelTemplate;
}
