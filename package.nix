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
  version = "Nightly-Rolling-unstable-2026-08-07";

  src = fetchFromGitHub {
    owner = "NanashiTheNameless";
    repo = "OrcaSlicer";
    rev = "f1104050d4e03a7e01f67a3374f1e3e178f674cc";
    hash = "sha256-mOwGMOcKhnv1QNa/HIrrqlR1L4PlUQr5/io2aD2riQ8=";
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
