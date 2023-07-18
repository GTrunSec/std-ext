{inputs}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.std) dmerge;
  inherit (inputs.std.lib) cfg;
  inherit (inputs.cells.common.lib) __inputs__;
  l = nixpkgs.lib // builtins;
in
  with dmerge; {
    default = {
      packages = [
        nixpkgs.alejandra
        __inputs__.nixpkgs-release.legacyPackages.nodePackages.prettier
        nixpkgs.shfmt
        nixpkgs.nodePackages.prettier-plugin-toml
      ];
      devshell.startup.prettier-plugin-toml = l.stringsWithDeps.noDepEntry ''
        export NODE_PATH=${__inputs__.nixpkgs-release.legacyPackages.nodePackages.prettier-plugin-toml}/lib/node_modules:''${NODE_PATH-}
      '';
      data = {
        formatter = {
          nix = {
            command = "alejandra";
            includes = ["*.nix"];
          };
          prettier = {
            command = "prettier";
            options = ["--plugin" "prettier-plugin-toml" "--write"];
            includes = [
              "*.css"
              "*.html"
              "*.js"
              "*.json"
              "*.jsx"
              "*.md"
              "*.mdx"
              "*.scss"
              "*.ts"
              "*.yaml"
              "*.toml"
            ];
          };
          shell = {
            command = "shfmt";
            options = ["-i" "2" "-s" "-w"];
            includes = ["*.sh"];
          };
        };
      };
    };
    julia = {
      data.formatter.prettier = {
        includes = prepend [
          ""
        ];
        excludes = prepend [
          "Manifest.toml"
          "Project.toml"
        ];
      };
    };
    rust = {
      data.formatter.prettier = {
        includes = prepend [
          ".rustfmt.toml"
        ];
      };
    };
    nvfetcher = {
      data.formatter.prettier = {
        excludes = prepend [
          "generated.json"
        ];
      };
      data.formatter.nix = {
        excludes = prepend [
          "generated.nix"
        ];
      };
    };
    nix = {
      data.formatter.prettier = {
        excludes = prepend [
          ".nix.toml"
        ];
      };
    };

    topiary = {
      data.formatter.topiary = {
        command = "topiary";
        options = ["--in-place" "--input-file"];
      };
      packages = append [
        nixpkgs.topiary
      ];
    };
  }
