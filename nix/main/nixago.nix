{
  inputs,
  cell,
}: let
  inherit (inputs) std nixpkgs data-merge;
in {
  treefmt = std.std.nixago.treefmt {
    configData.formatter.nix = {
      excludes = [
        "generated.nix"
      ];
    };
    configData.formatter.prettier = {
      excludes = [
        "secrets*.yaml"
        "Manifest.toml"
        "Project.toml"
      ];
    };
  };
  mdbook = std.std.nixago.mdbook {
    configData = {
      book.title = "Cells Lab Doc";
    };
  };
}
