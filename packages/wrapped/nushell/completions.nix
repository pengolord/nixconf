{
  lib,
  pkgs,
}: ''
  let carapace_completer = {|spans|
    ${lib.getExe pkgs.carapace} $spans.0 nushell ...$spans | from json
  }

  $env.config.completions.external = {
    enable: true
    completer: $carapace_completer
  }
''
