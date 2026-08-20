# Common configuration shared by every machine (laptop, pc, homelap).
# Only put things here that should be identical everywhere. Anything that
# differs between machines belongs in that machine's own file
# (laptop.nix / pc.nix / homelap.nix).
{ config, pkgs, ... }:

{
  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    TERMINAL = "kitty";
  };

  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [ "8.8.8.8" "8.8.4.4" ];

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-unikey
      fcitx5-gtk
      #fcitx5-qt
    ];
  };

  environment.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
  };

  # Enable the GNOME Desktop Environment / X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nouveau" "modesetting" ];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:ctrl_modifier";
    };
  };

  hardware.opengl = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
    wl-clipboard
    ripgrep
    fzf
  ];

  # Blacklist NVIDIA proprietary modules
  boot.blacklistedKernelModules = [
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"
  ];

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
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      courier-prime    # chứa Nimbus Mono PS
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      ipaexfont
      ipafont
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
      subpixel = {
        rgba = "rgb";
      };
    };
  };

  # Define the main user account. Don't forget to set a password with 'passwd'.
  users.users.okmuc216 = {
    isNormalUser = true;
    description = "okmuc216";
    extraGroups = [ "networkmanager" "docker" "wheel" ];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  services.ratbagd.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    zlib
    ncurses5
    stdenv.cc.cc
    stdenv.cc.cc.lib
    gcc
    binutils
  ];

  programs.zsh.enable = true;

  # Gỡ GNOME Console
  environment.gnome.excludePackages = with pkgs; [
    gnome-console
  ];

  # Docker (each host still lists its own docker/docker-compose packages).
  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's fine to leave this at the release
  # version of the first install of this system.
  system.stateVersion = "26.05";
}
