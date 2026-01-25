# PC-specific configuration
{ config, pkgs, ... }:

# To customize for PC, edit this file as needed.
{
  # Bootloader.
  boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vscode
    jdk17
    neofetch
    zsh
    dart
    brave
    git
    flutter
    android-studio
    google-chrome
    lm_sensors
    htop
    piper
    python3
    python3Packages.pip  # cài luôn pip
    nodejs_22
    kitty
    fira-code  
    nautilus
    fira-code  
    gnome-tweaks
    tmux
    jetbrains-toolbox
    termius
    filezilla
    postman
    anydesk
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    docker
    docker-compose
    maven
    unzip
    mkcert
    microsoft-edge
    protonvpn-gui
    flameshot
    gnome-extensions-cli
    gnomeExtensions.blur-my-shell
    cmake
    clang
    glibc
    zlib
    ncurses5
    patchelf
    ninja
    pkg-config
    gtk3
    yarn
    rustdesk
    fcitx5
    #  wget
  ];

  
}
