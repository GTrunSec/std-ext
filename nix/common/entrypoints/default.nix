{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.lib) writeShellApplication writeGlowDoc;
  inherit (inputs) self nixpkgs std;
in {
  mkdoc = let
    org-roam-book = inputs.org-roam-book-template.packages.${nixpkgs.system}.default.override {
      org = "${(std.incl self ["docs"])}/docs/org";
    };
  in
    writeShellApplication {
      name = "mkdoc";
      runtimeInputs = [nixpkgs.hugo];
      text = ''
        rsync -avzh ${org-roam-book}/* docs/publish
        cd docs/publish && cp ../config.toml .
        hugo "$@"
        cp -rf --no-preserve=mode,ownership public/posts/index.html ./public/
      '';
    };

  doc = writeGlowDoc {
    name = "Std doc";
    src = "${inputs.std}/docs";
    tip = ''
      example: std-doc `flag`
    '';
  };
  update-lock = writeShellApplication {
    name = "update-lock";
    text = ''
      # shellcheck disable=all
      sed -i 's|NixOS/nixpkgs/.*."|NixOS/nixpkgs/'$(nix flake metadata --json | jq -r ".locks.nodes.nixpkgs.locked.rev")'"|' lock/flake.nix
      nix flake update ./lock
    '';
  };
}
