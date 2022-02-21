{
  inputs,
  system,
}:
let
  nixpkgs = inputs.nixpkgs;
  lib = inputs.nixpkgs.lib;
  nickel = inputs.nickel.defaultPackage.${system.host.system};
  library = inputs.self.library.${system.build.system};
  writeShellApplication = library._writers-writeShellApplication;

  nickelTemplate =
    {
      name,
      # enum [ "json" "yaml" "toml" "raw"]
      format ? "json",
      args ? [],
      file,
    }:
      writeShellApplication {
        name = "nickel-genernater";
        runtimeInputs = [ nickel ];
        text = ''
        nickel -f ${file} export --format ${format}
        '';
      };
in
{
  inherit nickelTemplate;
}
