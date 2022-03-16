{
  __nixpkgs__,
  makeTemplate,
}: {
  name ? "makeSubstitution",
  env,
  source,
}:
makeTemplate {
  inherit name;
  replace = env;
  template = source;
}
