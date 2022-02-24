{
  inputs,
  system,
}: let
  packages = inputs.self.packages.${system.build.system};
  library = inputs.self.library.${system.build.system};
  nixpkgs = inputs.nixpkgs;
  glamourTemplate = library._templates-glamourTemplate;
  writeShellApplication = library._writers-writeShellApplication;
  test = glamourTemplate {
    hello = ''
      # Hello World
      This is a simple example of Markdown rendering with Glamour!
      Check out the [other examples](https://github.com/charmbracelet/glamour/tree/master/examples) too.
      Bye!
    '';
    comment_1 = ''
      # comment_1
      this is the second example of Markdown
    '';
    comment_2 = ''
      # comment_2
      this is the third example of Markdown
    '';
  };
in {
  inherit test;
  shell = writeShellApplication {
    name = "shell";
    runtimeInputs = [test];
    text = ''
      glamour-custom --
      echo "test Shell glamour"

      # glamour-custom --<comment_1>
      echo "test Shell glamour _2"
      # glamour-custom --<comment_2>
      echo "test Shell glamour _2"
    '';
  };
}
