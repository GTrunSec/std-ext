{
  lib,
  pythonPackages,
  fetchFromGitHub,
}:
pythonPackages.buildPythonPackage rec {
  pname = "cliche";
  version = "363c301afc11e739bec5a1798dd5e9216c7181be";
  src = fetchFromGitHub {
    owner = "kootenpv";
    repo = "cliche";
    rev = version;
    fetchSubmodules = false;
    sha256 = "sha256-HzBzS8GKZLOPaWv68nieZqo7E4xNGIEQsis4CrLDXiA=";
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
