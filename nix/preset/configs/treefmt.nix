{inputs}: let
  inherit (inputs.std) dmerge;
in
  with dmerge; {
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
  }
