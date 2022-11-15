{
  lib,
  pythonPackages,
  fetchFromGitHub,
}:
pythonPackages.buildPythonPackage rec {
  pname = "cliche";
  version = "a13b7e9bf0c0e4f4073da03ae7f2273055232711";
  src = fetchFromGitHub {
    owner = "kootenpv";
    repo = "cliche";
    rev = version;
    fetchSubmodules = false;
    sha256 = "sha256-wGBDylebd8DREU8LxgAy+r1MvuXlWbMRSspmMN466jQ=";
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
