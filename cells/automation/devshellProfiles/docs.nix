_: {
  commands = [
    {
      name = "mkdoc";
      command = "nix run $PRJ_ROOT#x86_64-linux.automation.entrypoints.mkdoc --refresh -- $@";
      help = "mkdoc with org-roam-book";
      category = "docs";
    }
  ];
}
