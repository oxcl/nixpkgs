{ buildPythonPackage
, fetchFromGitHub
, fetchpatch
, lib

# build-system
, poetry-core

# dependencies
, django
, markdown
, pyyaml

# tests
, beautifulsoup4
, pytestCheckHook
, pytest-django
}:

buildPythonPackage rec {
  pname = "django-pattern-library";
  version = "1.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "torchbox";
    repo = "django-pattern-library";
    rev = "refs/tags/v${version}";
    hash = "sha256-9uuLYwG0/NYGouncuaN8S+3CBABSxSOkcrP59p5v84U=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    django
    pyyaml
    markdown
  ];

  nativeCheckInputs = [
    beautifulsoup4
    pytestCheckHook
    pytest-django
  ];

  env.DJANGO_SETTINGS_MODULE = "tests.settings.dev";

  pythonImportsCheck = [ "pattern_library" ];

  meta = with lib; {
    description = "UI pattern libraries for Django templates";
    homepage = "https://github.com/torchbox/django-pattern-library/";
    changelog = "https://github.com/torchbox/django-pattern-library/blob/v${version}/CHANGELOG.md";
    license = licenses.bsd3;
    maintainers = with maintainers; [ sephi ];
  };
}
