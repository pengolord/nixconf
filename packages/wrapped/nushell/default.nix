_: {
  inputs = {
    flake.path = "/flake";
  };

  options.shellInit.mutators = [
    "/nushell"
    "/starship"
  ];

  mutations."/nushell".shellInit = {inputs}: ''
    $env.config.show_banner = false
    $env.config.shell_integration.osc8 = true
    $env.EDITOR = '${inputs.flake.pkgs.neovim}'

    ${import ./completions.nix inputs.nixpkgs}
    ${import ./direnv.nix inputs.nixpkgs}
  '';
}
