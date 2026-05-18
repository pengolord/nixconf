let
  pengo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDydOmWQyKXMKPWyk8yTQOJSmBtdWBt/z1OdKUuPXm8 pengo@";

  amethyst = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA/CzI/XemDnjDGJQsxAgxsrcyxK0e/Lfkct7Frdf70+ root@amethyst";
  granite = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOI1SDhVvlHR4x/Hevh1B1AQmXJtL8wnwlnQkaGAlsqa root@nixos";
  quartz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwfJFtTrjh6PU7UkQgdwglT5YwaU5CJMYfWw0z8vhec root@quartz";
  hosts = [
    amethyst
    granite
    quartz
  ];
in {
  "system/cloudflareToken.age".publicKeys = [pengo granite];
  "user/hashedPasswordFile.age".publicKeys = [pengo] ++ hosts;
}
