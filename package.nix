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
  version = "Nightly-Rolling-unstable-2026-07-19";

  src = fetchFromGitHub {
    owner = "NanashiTheNameless";
    repo = "OrcaSlicer";
    rev = "48a8c908816f43750150df3d793afdd50446c1fd";
    hash = "sha256-eFJS4eM8dddK+VBnuUgySgoKxkmye0m+ewlmqRdACe4=";
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
