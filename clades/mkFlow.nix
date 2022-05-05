{inputs}: name: {
  inherit name;
  clade = "make Flow";
  actions = {
    system,
    flake,
    fragment,
    fragmentRelPath,
    cell,
  }: [
    {
      name = "cargo-make";
      description = "run a cargo-make flow";
      command = ["nix" "run" "${flake}#${fragment}"];
    }
  ];
}
