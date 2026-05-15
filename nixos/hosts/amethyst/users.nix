{
  config,
  ...
}: {
  userModules.pengo = {
    enable = true;
    isAdministrator = true;
    desktop.enable = true;
  };

  users.users.pengo.hashedPasswordFile = config.age.secrets.pengoHashedPasswordFile.path;
}
