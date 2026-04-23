# === Aliases ===

alias vim=nvim
alias vi=nvim
alias nx-switch='nixos-rebuild --sudo switch --flake $@'
alias nx-test='nixos-rebuild --sudo test --flake $@'
alias nx-boot='nixos-rebuild --sudo boot --flake $@'
alias nx-gc='nix-collect-garbage --delete-older-than 3d'
