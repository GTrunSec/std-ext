{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    cells-lab.url = "github:GTrunSec/cells-lab";

    yants.follows = "cells-lab/yants";
    org-roam-book-template.follows = "cells-lab/org-roam-book-template";
    std.follows = "cells-lab/std";
    data-merge.follows = "cells-lab/data-merge";
  };
  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./cells;
      organelles = [
        (std.installables "packages")

        (std.functions "devshellProfiles")
        (std.devshells "devshells")

        (std.runnables "entrypoints")

        (std.functions "library")

        (std.functions "packages")

        (std.functions "overlays")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["main" "devshells"];
    };
}
