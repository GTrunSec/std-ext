{
  inputs,
  cell,
}: let
  inherit (inputs) std nixpkgs std-data-collection;
in {
  treefmt = std-data-collection.data.configs.treefmt {
    data.formatter.nix = {
      excludes = [
        "generated.nix"
      ];
    };
    data.formatter.prettier = {
      excludes = [
        "secrets*.yaml"
        "Manifest.toml"
        "Project.toml"
        "generated.json"
      ];
    };
  };
  mdbook = std-data-collection.data.configs.mdbook {
    data = {
      book.title = "Cells Lab Doc";
    };
  };
}
