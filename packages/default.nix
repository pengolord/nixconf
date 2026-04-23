{ lib, ... } @args:

let
  inherit (lib) genAttrs;
  inherit (builtins) attrNames filter pathExists readDir;
  contentsOf = dir: attrNames (readDir dir);

  # Gets the name of every sibling directory that has a 'package.nix' file.
  hasPackageFile = path: pathExists ./${path}/package.nix;
  packageNames = filter hasPackageFile (contentsOf ./.);

  packages = genAttrs packageNames (packageName:
    import ./${packageName}/package.nix args
  );
in
packages
