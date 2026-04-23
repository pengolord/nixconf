{ inputs, pkgs-unstable, ... }:

inputs.wrapper-modules.wrappers.git.wrap {
  pkgs = pkgs-unstable;

  settings = {
    user.name = "pengo";
    user.email = "pbalternates@gmail.com";

    diff.algorithm = "histogram";
    init.defaultBranch = "master";
    rerere.enabled = true;

    merge.conflictstyle = "zdiff3";
    pull.rebase = true;
    push.autoSetupRemote = true;
  };
}
