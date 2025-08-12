{ config, user, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
        c = "clear";
        ls = "eza -la";
        up = "sudo nix flake update && sudo nixos-rebuild switch --flake /home/${user}/nixos-configs --upgrade";
        rebuild-vm = "sudo nixos-rebuild switch --flake /home/${user}/nixos-configs#nixxx";
        rebuild-desktop = "sudo nixos-rebuild switch --flake /home/${user}/nixos-configs#desktop";
        homerebuild = "home-manager switch --flake /home/${user}/nixos-configs";
        poff = "poweroff";
        gc = "sudo nix-collect-garbage -d";
        nix-clean = "sudo nix store optimise && sudo nix-collect-garbage -d";
    };

    history.size = 10000;
  };
}