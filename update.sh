#!/usr/bin/env bash
set -euo pipefail

script_dir="$(dirname "$(readlink -f "$0")")"
pkg_file="$script_dir/package.nix"

owner="NanashiTheNameless"
repo="OrcaSlicer"
tag="Nightly-Rolling"

# Resolve the tag to a commit, dereferencing annotated tags if needed.
tag_ref=$(gh api "repos/$owner/$repo/git/ref/tags/$tag")
object_sha=$(echo "$tag_ref" | jq -r '.object.sha')
object_type=$(echo "$tag_ref" | jq -r '.object.type')

if [[ "$object_type" == "tag" ]]; then
  commit_sha=$(gh api "repos/$owner/$repo/git/tags/$object_sha" --jq '.object.sha')
else
  commit_sha="$object_sha"
fi

current_rev=$(grep -oP 'rev = "\K[^"]+' "$pkg_file")

if [[ "$commit_sha" == "$current_rev" ]]; then
  echo "orca-slicer-nanashi is up to date at $current_rev" >&2
  exit 0
fi

commit_date=$(gh api "repos/$owner/$repo/commits/$commit_sha" --jq '.commit.committer.date' | cut -dT -f1)
new_version="Nightly-Rolling-unstable-$commit_date"

new_hash=$(nix run nixpkgs#nix-prefetch-github -- "$owner" "$repo" --rev "$commit_sha" | jq -r '.hash')

sed -i "s|rev = \"[^\"]*\"|rev = \"$commit_sha\"|" "$pkg_file"
sed -i "s|version = \"[^\"]*\"|version = \"$new_version\"|" "$pkg_file"
sed -i "s|hash = \"[^\"]*\"|hash = \"$new_hash\"|" "$pkg_file"

(cd "$script_dir" && nix flake update)

echo "orca-slicer-nanashi: $current_rev -> $commit_sha ($new_version)" >&2

if [[ -n "${CI:-}" ]]; then
  cd "$script_dir"
  git config user.name "github-actions[bot]"
  git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
  git add package.nix flake.lock
  git commit -m "orca-slicer-nanashi: $current_rev -> $commit_sha"
  git push
fi
