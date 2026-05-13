{inputs, ...}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;

    directories = [
      # Ssh host keys are needed for accessing secrets and for telling hosts apart.
      "/etc/ssh"

      # Preserves log files, so I can see what happened in case of issues
      "/var/log"
      # Important libraries to keep persisted
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
    ];

    files = [
      "/etc/machine-id"
    ];
  };
}
