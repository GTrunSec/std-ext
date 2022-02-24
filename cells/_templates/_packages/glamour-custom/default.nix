{buildGoApplication,}:
buildGoApplication rec {
  name = "glamour-custom";
  src = ./.;
  modules = ./gomod2nix.toml;
  meta = {
    description = "Stylesheet-based markdown rendering for your CLI apps 💇🏻‍♀️";
    homepage = "https://github.com/charmbracelet/glamour";
  };
}
