{ inputs, cell }:
let
  inherit (inputs) std;
in
{
  mdbook = std.presets.nixago.mdbook {
    data = {
      book.title = "Std Template";
    };
  };

  treefmt = std.presets.nixago.treefmt {
    data.formatter.nix = {
      excludes = [ "generated.nix" ];
    };
    data.formatter.prettier = {
      excludes = [
        "conf/*"
        "data/*"
      ];
    };
  };
}
