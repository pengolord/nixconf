let
  inherit (builtins) readFile;

  lock = fromTOML (readFile ./lock.toml);
in {
  mnw = fetchGit lock.mnw;
}
