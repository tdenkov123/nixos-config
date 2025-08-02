{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    colors = "always";
    git = true;
    icons = "always";
    extraOptions = [
      "--header"
      "--group-directories-first"
    ];
  };
}
