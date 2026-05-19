{pkgs, ...}: {
  services.nginx.virtualHosts."pengo.uk" = {
    forceSSL = true;
    useACMEHost = "pengo.uk";
    root = import ./package.nix pkgs;
    locations."/".extraConfig = "try_files $uri $uri/ /index.html;";
  };
}
