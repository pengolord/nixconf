{ config, ... }:

{
  imports = [
    ./pengo.uk
  ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "pbalternates+acme@gmail.com";
    certs."pengo.uk" = {
      domain = "pengo.uk";
      extraDomainNames = ["*.pengo.uk"];
      group = "nginx";
      dnsProvider = "cloudflare";
      credentialFiles.CF_DNS_API_TOKEN_FILE = config.age.secrets.cloudflareToken.path;
    };
  };

  age.secrets.cloudflareToken.file = ../../../../../secrets/system/cloudflareToken.age;
}
