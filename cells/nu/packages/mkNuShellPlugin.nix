{
  rustPlatform,
  shell-sources,
  lib,
}: package:
rustPlatform.buildRustPackage rec {
  inherit (shell-sources."${package}") src pname version;
  cargoLock.lockFile = shell-sources."${package}".cargoLock."Cargo.lock".lockFile;
  meta.mainProgram = lib.replaceStrings ["-"] ["_"] pname;
}
