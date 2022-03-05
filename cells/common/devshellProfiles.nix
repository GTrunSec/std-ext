{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.nixpkgs-hardenedlinux.overlays."nixpkgs/nixpkgs-hardenedlinux-sources"
  ];
  nvfetcher = inputs.nvfetcher.defaultPackage;
in {
  default = _: {
    devshell.startup.variables-setuphook =
      nixpkgs.lib.stringsWithDeps.noDepEntry ''
      '';
    commands = [
      {
        package = nvfetcher;
        category = "Update";
      }
      {
        name = "nvfetcher-update";
        category = "Update";
        command = "export NIX_PATH=nixpkgs=${nixpkgs.path} \n" + nixpkgs.lib.fileContents ./nvfetcher-update.bash;
        help = "run nvfetcher with sources.toml <github-CI>";
      }
      {
        name = "nix-github-update";
        category = "Update";
        command =
          "export nixVersion=${toString nixpkgs.nixpkgs-hardenedlinux-sources.nix-unstable-installer.src.urls} \n"
          + nixpkgs.lib.fileContents ./nix-github-update.bash;
        help = "Update nix version on <github-CI>";
      }
      {
        name = "run-nvfetcher";
        category = "Update";
        command = "nvfetcher-update ./nix/sources.toml";
        help = "run nvfetcher with local repo's sources.toml";
      }
    ];
  };
}