{ pkgs, ... }:
{
  commands = [ {
    name = "mkdoc";
    command = "nix run $PRJ_ROOT#${pkgs.system}.automation.entrypoints.mkdoc --refresh -- $@";
    help = "mkdoc with org-roam-book";
    category = "docs";
  } ];
}
