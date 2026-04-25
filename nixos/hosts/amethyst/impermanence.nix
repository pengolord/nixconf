{ inputs, ... }:

{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;

    directories = [
      "/etc/ssh"
    ];
  };
}
