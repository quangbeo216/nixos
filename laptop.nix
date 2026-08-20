# Laptop-specific configuration.
{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  environment.systemPackages = with pkgs; [
    vscode
    jdk17
    fastfetch
    zsh
    brave
    git
    google-chrome
    lm_sensors
    htop
    piper
    python3
    python3Packages.pip  # cài luôn pip
    nodejs_22
    kitty
    fira-code
    nerd-fonts.fira-code
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-syntax-highlighting
    nautilus
    gnome-tweaks
    tmux
    jetbrains-toolbox
    termius
    filezilla
    postman
   #anydesk
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
    telegram-desktop
    navicat-premium
    #  wget
  ];

  services.tailscale.enable = true;
}
