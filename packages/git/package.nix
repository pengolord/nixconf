{
  inputs,
  pkgs,
  ...
}:
inputs.wrapper-modules.wrappers.git.wrap {
  inherit pkgs;

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
