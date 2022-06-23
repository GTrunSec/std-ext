inputs: {
  microvms = import ./microvms.nix inputs;
  files = import ./files.nix inputs;
  installables = import ./installables.nix inputs;
}
