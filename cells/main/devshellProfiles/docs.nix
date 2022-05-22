{...}:
{
  commands = [
    {
      name = "mkdoc";
      command = "nix run $PRJ_ROOT#x86_64-linux.main.entrypoints.mkdoc -- $@";
      help = "mkdoc with org-roam-book";
      category = "docs";
    }
  ];
}
