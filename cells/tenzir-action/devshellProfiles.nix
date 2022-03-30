{
  inputs,
  cell,
}: {
  default = _: {
    imports = [inputs.cells.tenzir.devshellProfiles.default];
    commands = [];
  };
}
