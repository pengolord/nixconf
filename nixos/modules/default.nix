{
  inputs,
  self,
  lib,
  ...
} @ args: {
  default = {pkgs, ...}: {
    # These modules will be imported by default.
    imports = [
      inputs.mangowm.nixosModules.mango
      inputs.agenix.nixosModules.default
      ./user
      ./system/nix-settings
    ];

    options.userModules.pengo._args = lib.mkOption {
      type = lib.types.attrs;
      description = ''
        Arguments passed to every module in my config. These are the same as the `getArgsFor` arguments defined in my `../../flake.nix`.
        My modules use these arguments instead of the builtin ones.

        Why? This makes my configuration actually portable.
        Another config that imports any of these modules will be using *my* package versions and inputs instead of theirs.
        If they want, since this is an option, they can always override it to use theirs.
        This makes it completely portable and reproducible, unlike using `specialArgs`.

        To use them, I pull them from the built-in `config` attribute:
        `inherit (config.userModules.pengo._args) /* arguments I want to pull in go here */;`
      '';
      default = let
        # `pkgs` is guaranteed to be an argument, so these modules are still portable despite me taking `system` from it.
        system = pkgs.stdenv.hostPlatform.system;
      in
        args
        // {
          inherit system;
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          pkgs-self = self.packages.${system};
        };
    };
  };

  user = import ./user;
}
