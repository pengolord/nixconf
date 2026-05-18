pkgs:
let
  src = pkgs.fetchFromGitHub {
    owner = "pengolord";
    repo = "website";
    rev = "master";
    hash = "sha256-lafIHF1nF6T3nA6yGSc9NMsBqIjgYZbFbRFbvieW/pA=";
  };
in pkgs.callPackage "${src}/package.nix" {}
