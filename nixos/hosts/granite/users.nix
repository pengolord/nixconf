{self, ...}: {
  imports = [self.nixosModules.user];

  userModules.pengo = {
    enable = true;
    isAdministrator = true;
  };

  users.users.pengo.extraGroups = ["docker"];
}
