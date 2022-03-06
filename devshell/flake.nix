{
  description = "Vast Cells development shell";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.devshell.url = "github:numtide/devshell";
  inputs.std.url = "github:divnix/std";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.main.url = "../.";
  outputs = inputs:
    inputs.flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin"] (
      system: let
        inherit
          (inputs.main.inputs.std.deSystemize system inputs)
          main
          devshell
          ;
        nixpkgs = inputs.nixpkgs.legacyPackages.${system};
        profiles = inputs.main.${system};
        inherit (main.inputs.std.deSystemize system main.inputs) std;
      in {
        inherit std;
        devShells.default = devshell.legacyPackages.mkShell {
          name = "DevSecOps Cells";
          imports = [
            std.std.devshellProfiles.default
            main.tenzir.devshellProfiles.default
            main.zeek.devshellProfiles.default
            main.cliche.devshellProfiles.default
            main.templates.devshellProfiles.default
            main.comonicon.devshellProfiles.default
            main.common.devshellProfiles.default
          ];
          commands = [];
          packages = [
            nixpkgs.shfmt
            nixpkgs.nodePackages.prettier
            nixpkgs.nodePackages.prettier-plugin-toml
            nixpkgs.python3Packages.black
          ];
          devshell.startup.nodejs-setuphook = nixpkgs.lib.stringsWithDeps.noDepEntry ''
            export NODE_PATH=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
          '';
        };
      }
    );
}
