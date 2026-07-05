{
  description = "OrcaSlicer nightly built from the NanashiTheNameless fork.";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    flake-parts.url = "https://flakehub.com/f/hercules-ci/flake-parts/*";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;

        packages = {
          default = pkgs.callPackage ./package.nix {};
          orca-slicer-nanashi = pkgs.callPackage ./package.nix {};
        };
      };
    };
}
