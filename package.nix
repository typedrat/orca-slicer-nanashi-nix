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
  version = "Nightly-Rolling-unstable-2026-07-13";

  src = fetchFromGitHub {
    owner = "NanashiTheNameless";
    repo = "OrcaSlicer";
    rev = "e43f6041c8a9ee43f57caa529fa3175583c96ee9";
    hash = "sha256-PpQ7zi76HipwIL2IrfprHpkqI2uBrnyIoIf8XW/mZXQ=";
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
