{
  inputs,
  cell,
} @ args: let
  nixpkgs = inputs.nixpkgs.appendOverlays [];
  inherit (inputs.cells._writers.library) writeShellApplication;
  eval = (import ./modules) nixpkgs;
in {
  makeExample = devshell:
    (eval {
      configuration = {inherit devshell;};
      extraSpecialArgs = {inherit inputs cell writeShellApplication;};
    })
    .config
    .devshell
    .shell;
}
