let
  inherit (builtins) readFile;

  lock = fromTOML (readFile ./lock.toml);
in {
  mnw = fetchGit lock.mnw;
  adios = fetchGit lock.adios;
  adios-wrappers = fetchGit lock.adios-wrappers;
}
