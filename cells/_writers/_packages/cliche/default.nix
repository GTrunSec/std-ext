{
  lib,
  pythonPackages,
  fetchFromGitHub,
}:
pythonPackages.buildPythonPackage rec {
  pname = "cliche";
  version = "2b0369de9473a832974c623724ba4e314e3af8f4";
  src = fetchFromGitHub {
    owner = "kootenpv";
    repo = "cliche";
    rev = version;
    fetchSubmodules = false;
    sha256 = "sha256-x09eZDcxljWA86+lXij6DIz0R3HYH18JNA37hEoIbqM=";
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
