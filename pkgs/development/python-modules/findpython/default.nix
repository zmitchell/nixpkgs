{
  lib,
  buildPythonPackage,
  fetchPypi,
  pythonOlder,

  # build time
  pdm-backend,

  # runtime
  packaging,

  # tests
  pytestCheckHook,
}:

let
  pname = "findpython";
  version = "0.6.3";
in
buildPythonPackage {
  inherit pname version;
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-WGPqVVVtiq3Gk0gaFKxPNiSVJxnvwcVZGrsLSp6WXJQ=";
  };

  nativeBuildInputs = [ pdm-backend ];

  propagatedBuildInputs = [ packaging ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "findpython" ];

  meta = with lib; {
    description = "Utility to find python versions on your system";
    mainProgram = "findpython";
    homepage = "https://github.com/frostming/findpython";
    changelog = "https://github.com/frostming/findpython/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ hexa ];
  };
}
