# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
nix.settings.experimental-features = [ "nix-command" "flakes" ];

 programs.dconf.enable = true;


services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  [org.gnome.settings-daemon.plugins.media-keys]
  custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']

  [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0]
  name='Toggle Overview'
  binding='<Control>space'
  command='gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval "Main.overview.toggle();"'
'';

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
environment.variables.TERMINAL = "kitty";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
  LC_ADDRESS       = "en_US.UTF-8";
  LC_IDENTIFICATION = "en_US.UTF-8";
  LC_MEASUREMENT   = "en_US.UTF-8";
  LC_MONETARY      = "en_US.UTF-8";
  LC_NAME          = "en_US.UTF-8";
  LC_NUMERIC       = "en_US.UTF-8";
  LC_PAPER         = "en_US.UTF-8";
  LC_TELEPHONE     = "en_US.UTF-8";
  LC_TIME          = "en_US.UTF-8";
};

  # Enable the X11 windowing system.
  services.xserver.enable = true;
i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-unikey        # Bộ gõ tiếng Việt
      fcitx5-gtk           # Hỗ trợ cho ứng dụng GTK
#      fcitx5-qt            # Hỗ trợ cho ứng dụng Qt
    ];
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
#services.docker.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
virtualisation.docker.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      hinting.style = "full";
      subpixel = {
        rgba = "rgb";
      };
    };
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.okmuc216 = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "okmuc216";
    extraGroups = [ "networkmanager" "docker"  "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
services.ratbagd.enable = true;
  # Install firefox.
  programs.firefox.enable = true;
nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vscode
  jdk17
  neofetch
  #jetbrains.idea-ultimate
  zsh
 (import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz") {}).dart
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
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

    # Bật nix-ld để chạy app ngoài NixOS (DataGrip, Android Studio…)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  glibc
    gtk3
    gtk2
    glib
    cairo
    pango
    atk
    gdk-pixbuf
    fontconfig
    freetype
    cups
    alsa-lib
    libdrm
    libuuid

    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.libXrandr
    xorg.libXtst
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXxf86vm
    xorg.libXScrnSaver
    xorg.libXft
  ];
    # Gỡ GNOME Console
  environment.gnome.excludePackages = with pkgs; [
    gnome-console
  ];
programs.zsh.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
