{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    automake
    cmake
    ninja
    valgrind
    kdePackages.kcachegrind
    git-graph
    vscode
    sublime4
    neovim
    (python313.withPackages (ps: with ps; [ pip setuptools wheel pyqt5 ]))
    qt5.qtwayland
    qt5.qtbase
    qt5.qtdeclarative
    jupyter
    ripgrep
    silicon
    opcua-client-gui
    gtk3
    gsettings-desktop-schemas
    glib
    go
  ];
}