{lib, ...} @ args: let
  inherit (lib.modules) importApply;

  pinModule = path:
    importApply path args;
in {
  desktop = pinModule ./desktop;
  nix-settings = pinModule ./nix-settings;
  secrets = pinModule ./secrets;
  shell = pinModule ./shell;
  user = pinModule ./user;
}
