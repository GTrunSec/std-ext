{
  inputs,
  system,
}: let
  packages = inputs.self.packages.${system.build.system};
  library = inputs.self.library.${system.build.system};
  nixpkgs = inputs.nixpkgs;
  glamourTemplate = library._templates-glamourTemplate;
in {
  test = glamourTemplate {
    hello = ''
      # Hello World
      This is a simple example of Markdown rendering with Glamour!
      Check out the [other examples](https://github.com/charmbracelet/glamour/tree/master/examples) too.
      Bye!
    '';
  };
}
