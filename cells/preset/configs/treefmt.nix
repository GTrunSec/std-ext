{inputs}: let
  inherit (inputs.std) dmerge;
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (__inputs__) topiary;
in
  with dmerge; {
    default = {
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
          "julia2nix.toml"
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
        options = ["--in-place" "--input-files"];
        includes = [
          "*.ncl"
        ];
      };
      packages = [
        topiary.packages.default
      ];
    };
  }
