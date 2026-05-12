_: {
  options.settings.default = {
    user = {
      name = "pengo";
      email = "pbalternates@gmail.com";
    };

    diff.algorithm = "histogram";
    init.defaultBranch = "master";
    rerere.enabled = true;

    merge.conflictstyle = "zdiff3";
    pull.rebase = true;
    push.autoSetupRemote = true;

    alias = {
      amend = "commit --amend --no-edit";
      unstage = "restore --staged";
    };
  };
}
