{
  makeEnvVars,
  __nixpkgs__,
  __output__,
}: let
  makeEnvVarsOutput = (mapping:
    makeEnvVars {
      name = "makeEnvVars";
      inherit mapping;
    })
    __output__;
in
  makeEnvVarsOutput
