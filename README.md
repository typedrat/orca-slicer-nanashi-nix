# orca-slicer-nanashi-nix

[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/typedrat/orca-slicer-nanashi-nix/badge)](https://flakehub.com/flake/typedrat/orca-slicer-nanashi-nix)
[![CI](https://github.com/typedrat/orca-slicer-nanashi-nix/actions/workflows/ci.yml/badge.svg)](https://github.com/typedrat/orca-slicer-nanashi-nix/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A Nix flake packaging the [NanashiTheNameless/OrcaSlicer](https://github.com/NanashiTheNameless/OrcaSlicer)
fork's rolling `Nightly-Rolling` build. It reuses nixpkgs' `orca-slicer` build
recipe and patch set wholesale, swapping in only the upstream source.

## Usage

Run it directly:

```sh
nix run "https://flakehub.com/f/typedrat/orca-slicer-nanashi-nix/*#default"
```

Or add it as a flake input:

```nix
{
  inputs.orca-slicer-nanashi.url = "https://flakehub.com/f/typedrat/orca-slicer-nanashi-nix/*";
}
```

The flake exposes `packages.<system>.default` (aliased as `orca-slicer-nanashi`)
for `aarch64-linux` and `x86_64-linux`.

## Updates

`update.sh` checks the upstream `Nightly-Rolling` tag, and if it has moved,
re-pins `package.nix` to the new commit, refreshes its hash, and updates
`flake.lock`. The `check-update` workflow runs it on a schedule and pushes any
resulting changes directly to `master`.

## License

This flake's packaging code is licensed under the [MIT License](LICENSE).
OrcaSlicer itself is licensed separately by its upstream project.
