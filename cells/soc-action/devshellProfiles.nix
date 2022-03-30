{
  inputs,
  cell,
}: {
  default = _: {
    imports = [
      inputs.cells.zeek-action.devshellProfiles.default
      inputs.cells.tenzir-action.devshellProfiles.default
    ];
    commands = [];
  };
}
