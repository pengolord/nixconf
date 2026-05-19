let
  inherit (builtins) readFile;

  lock = fromTOML (readFile ./lock.toml);
in {
  mnw = fetchGit lock.mnw;
  adios = fetchGit lock.adios;
  adios-wrappers = fetchGit lock.adios-wrappers;
  mangowm = fetchGit lock.mangowm;
  noctalia-shell = fetchGit lock.noctalia-shell;
  agenix = fetchGit lock.agenix;
  impermanence = fetchGit lock.impermanence;
}
