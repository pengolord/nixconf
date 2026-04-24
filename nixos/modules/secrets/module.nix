{ inputs, ... }:

{
  imports = [ inputs.agenix.nixosModules.default ];

  age.secrets = {
    pengoHashedPasswordFile.file = ../../../secrets/user/hashedPasswordFile.age;
  };
}
