{
  inputs,
  cell,
}: let
  inherit (inputs) std;
  inherit (std.lib.ops) mkDevOCI mkSetup;

  l = inputs.nixpkgs.lib // builtins;
in {
  dev = mkDevOCI {
    name = "ghcr.io/gtrunsec/desci.devshell";
    tag = "latest";
    devshell = cell.devshells.default;
    labels = {
      title = "Decentralized Data Science";
      version = "latest";
      url = "https://github.com/GTrunSec/DeSci/nix/data";
      source = "https://github.com/GTrunSec/DeSci/nix/data/devshells";
      description = ''
        A preconfiged devshell for analyzing dataset
      '';
    };
    setup = [
      (mkSetup "nushell-config" [
          {
            path = "/home/user/.config/nushell";
            mode = "0777";
          }
        ] ''
          mkdir -p $out/home/user/.config/nushell
        '')
    ];
  };
}
