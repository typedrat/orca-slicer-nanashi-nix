{
  fetchFromGitHub,
  orca-slicer,
}:
# NanashiTheNameless maintains a rolling nightly of OrcaSlicer whose
# `Nightly-Rolling` tag always points at the tip of `main`, so pin the commit
# and let ./update.sh follow that tag. The upstream build recipe and its patch
# set are reused wholesale; only the source is swapped.
orca-slicer.overrideAttrs (prev: {
  pname = "orca-slicer-nanashi";
  version = "Nightly-Rolling-unstable-2026-11-07";

  src = fetchFromGitHub {
    owner = "NanashiTheNameless";
    repo = "OrcaSlicer";
    rev = "b2e8c9769a63bf39d1c1f4384ab6da47a04a0819";
    hash = "sha256-hCqpoZMU4tjnlGeAFahoc8jtnolraV0AjWvAjLiZZ+A=";
  };

  passthru =
    (prev.passthru or {})
    // {
      updateScript = ./update.sh;
    };

  meta =
    prev.meta
    // {
      description = "OrcaSlicer nightly built from the NanashiTheNameless fork";
      homepage = "https://github.com/NanashiTheNameless/OrcaSlicer";
      changelog = "https://github.com/NanashiTheNameless/OrcaSlicer/releases/tag/Nightly-Rolling";
    };
})
