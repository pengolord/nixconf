_: {
  inputs.self.path = "/starship";

  options.settings.default = {
    add_newline = false;

    format =
      "$username"
      + "$hostname"
      + "$directory"
      + "$git_branch"
      + "$git_state"

      + "$fill"

      + "$cmd_duration"
      + "$nix_shell"
      + "$line_break"
      + "$character"
      ;

    username = {
      show_always = true;
      format = "[$user](blue)@";
    };

    hostname = {
      ssh_only = false;
      format = "[$hostname](blue):";
    };

    directory.style = "yellow";
    git_branch.style = "red";
    nix_shell.symbol = "[󱄅 ](blue) ";
  };

  mutations."/nushell".shellInit = {inputs}: ''
    $env.STARSHIP_SHELL = "nu"

    def create_left_prompt [] {
        ${inputs.nixpkgs.lib.getExe (inputs.self {})} prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
    }

    $env.PROMPT_COMMAND = { || create_left_prompt }
    $env.PROMPT_COMMAND_RIGHT = ""

    $env.PROMPT_INDICATOR = ""
    $env.PROMPT_INDICATOR_VI_INSERT = ": "
    $env.PROMPT_INDICATOR_VI_NORMAL = "〉"
    $env.PROMPT_MULTILINE_INDICATOR = "::: "
  '';
}
