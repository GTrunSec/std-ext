{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [];
  inherit (inputs.cells._writers.library) writeShellApplication;
  eval = (import ./modules) nixpkgs;
in rec {
  makeCommonNomad = name: branch: source:
    makeConfiguration {
      inherit name branch source;
      target = "nomad";
      format = "json";
    };

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
