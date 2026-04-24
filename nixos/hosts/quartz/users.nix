{ self, ... }:

{
  imports = [ self.nixosModules.user ];

  userModules.pengo = {
    enable = true;
    isAdministrator = true;
    desktop.enable = true;
  };
}
