{
  inputs,
  cell,
} @ args: let
  nixpkgs = inputs.nixpkgs.appendOverlays [];
  inherit (inputs.cells._writers.library) writeShellApplication;
  eval = (import ./modules) nixpkgs;
in {
  makeConfigurationFromLang = templates:
    (eval {
      configuration = {inherit templates;};
      extraSpecialArgs = {inherit inputs cell writeShellApplication;};
    })
    .config
    .templates
    .makeConfigurationFromLang;

  makeConfiguration = templates:
    (eval {
      configuration = {inherit templates;};
      extraSpecialArgs = {inherit inputs cell writeShellApplication;};
    })
    .config
    .templates
    .makeConfiguration;

  makeSocProfile = socProfile:
    (eval {
      configuration = {inherit socProfile;};
      extraSpecialArgs = {inherit inputs cell writeShellApplication;};
    })
    .config
    .socProfile
    .makeSocProfile;
}
