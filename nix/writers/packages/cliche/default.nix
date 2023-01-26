{
  lib,
  pythonPackages,
  fetchFromGitHub,
}:
pythonPackages.buildPythonPackage rec {
  pname = "cliche";
  version = "80a9ae2e90f4493880b669d5db51f1d4038589df";
  src = fetchFromGitHub {
    owner = "kootenpv";
    repo = "cliche";
    rev = version;
    fetchSubmodules = false;
    sha256 = "sha256-7/icSneLQzwdkRL/mS4RjsgnKa6YIVvGCmdS6pB6r5Y=";
  };

  checkInputs = with pythonPackages; [pytestCheckHook];

  patches = [./nix-cliche.patch];

  doCheck = true;

  propagatedBuildInputs = with pythonPackages; [ipdb argcomplete];

  meta = with lib; {
    description = "Build a simple command-line interface from your functions 💻";
    homepage = "https://github.com/kootenpv/cliche";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
