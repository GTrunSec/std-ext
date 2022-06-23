{ inputs, cell }:

{

  a = inputs.nixpkgs.writeText "network.cfg" ''
    [logger]
    type = logger
    host=
    '';
}
