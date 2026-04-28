let
  users.pengo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDydOmWQyKXMKPWyk8yTQOJSmBtdWBt/z1OdKUuPXm8 pengo@";

  hosts = {
    amethyst = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA/CzI/XemDnjDGJQsxAgxsrcyxK0e/Lfkct7Frdf70+ root@amethyst";
    quartz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwfJFtTrjh6PU7UkQgdwglT5YwaU5CJMYfWw0z8vhec root@quartz";
  };
in {
  "user/hashedPasswordFile.age".publicKeys = [users.pengo hosts.quartz hosts.amethyst];
}
