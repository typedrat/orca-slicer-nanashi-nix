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
  version = "Nightly-Rolling-unstable-2026-09-27";

  src = fetchFromGitHub {
    owner = "NanashiTheNameless";
    repo = "OrcaSlicer";
    rev = "d706586f921a59ade3356f210985a316a3c88d78";
    hash = "sha256-XmEkAQGS9gkv8fA5dkbFJPLqWS+0bYmooswNtoPZNSk=";
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
