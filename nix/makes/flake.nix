{
  description = "A very basic flake";
  inputs.vast.url = "github:tenzir/vast";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  outputs = inputs: {
    inherit inputs;
  };
}
