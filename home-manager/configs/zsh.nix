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
        rebuild = "sudo nixos-rebuild switch --flake /home/${user}/nixos-configs";
        homerebuild = "home-manager switch --flake /home/${user}/nixos-configs";
        poff = "poweroff";
    };

    history.size = 10000;
  };
}