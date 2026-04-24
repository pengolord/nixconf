{ lib, ... } @args:

let
  inherit (lib) genAttrs;
  inherit (lib.modules) importApply;
  inherit (builtins) attrNames filter pathExists readDir;
  contentsOf = dir: attrNames (readDir dir);

  # Gets the name of every sibling directory that has a 'module.nix' file.
  hasNixosModule = path: pathExists ./${path}/module.nix;
  moduleNames = filter hasNixosModule (contentsOf ./.);

  # All of these modules are functions that return a module; this lets the modules be more self-reliant and pin their packages to whatever I'm using instead of whatever the host is using
  # This is not a good idea unless you know what you are doing
  pinNixosModule = moduleName:
    importApply ./${moduleName}/module.nix args;

  modules = genAttrs moduleNames pinNixosModule;
in
modules
