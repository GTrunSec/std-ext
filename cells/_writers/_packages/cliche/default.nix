{
  lib,
  pythonPackages,
  fetchFromGitHub,
}:
pythonPackages.buildPythonPackage rec {
  pname = "cliche";
  version = "8e6eb57f1145aee4c43f2bc4e6a508b8922a152e";
  src = fetchFromGitHub {
    owner = "kootenpv";
    repo = "cliche";
    rev = version;
    fetchSubmodules = false;
    sha256 = "sha256-lr4M/dDM97M6mNpciJC8EVYAavf4Asbzoic/jgSt29c=";
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
