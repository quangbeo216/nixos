# PC-specific configuration
{ config, pkgs, ... }:

# To customize for PC, edit this file as needed.
{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  services.getty.autologinUser = "okmuc216";
  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    flameshot
    cloudflared
    pm2
    rustdesk
    #  wget
  ];
  services.tailscale.enable = true;
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  users.users.quangbeo216 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  services.tailscale.extraUpFlags = [ "--ssh" ];
  systemd.services.cloudflared = {
    description = "Cloudflare Tunnel";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.cloudflared}/bin/cloudflared tunnel run --token eyJhIjoiNzJiNTQ2MmU4ZGRmYjE3OTM0ZTU2ZGFjMTc2YTA2MjYiLCJ0IjoiYTdjY2Q5NDktZWY4MC00YWRmLWFlMjAtYjQxMDg1MWI3OWFmIiwicyI6Ik1qVTRZV1V4Wm1JdFpqWXpaaTAwWVdWaExXRmhZemd0WXpBMU56ZzVPR1k1TWpFeCJ9
      '';
      Restart = "always";
      RestartSec = 5;
    };
  };


  services.nginx = {
    enable = true;

    virtualHosts = {
#      "shopyensao.com" = {
#        locations."/" = {
#          proxyPass = "http://127.0.0.1:8050";  # port host map với Docker
#          proxyWebsockets = true;
#          extraConfig = ''
#            proxy_set_header Host              $host;
#            proxy_set_header X-Real-IP         $remote_addr;
#            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
#            proxy_set_header X-Forwarded-Proto $scheme;
#            proxy_set_header X-Forwarded-Host  $host;
#            proxy_set_header X-Forwarded-Port  $server_port;
#
#            # Giúp tránh redirect sai port hoặc scheme
#            proxy_redirect off;
#            proxy_buffering off;  # tùy chọn, đôi khi giúp nhanh hơn
#          '';
#        };
#
#      };
      "ranking.shopyensao.com" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:3033";  # port host map với Docker
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host              $host;
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host  $host;
            proxy_set_header X-Forwarded-Port  $server_port;

            # Giúp tránh redirect sai port hoặc scheme
            proxy_redirect off;
            proxy_buffering off;  # tùy chọn, đôi khi giúp nhanh hơn
          '';
        };

      };
 

      "crazyzo.com" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:30004";  # k3s NodePort
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host              $host;
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host  $host;
            proxy_set_header X-Forwarded-Port  $server_port;

            # Giúp tránh redirect sai port hoặc scheme
            proxy_redirect off;
            proxy_buffering off;  # tùy chọn, đôi khi giúp nhanh hơn
          '';
        };

      };
      "www.crazyzo.com" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:30004";  # k3s NodePort
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host              $host;
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host  $host;
            proxy_set_header X-Forwarded-Port  $server_port;

            # Giúp tránh redirect sai port hoặc scheme
            proxy_redirect off;
            proxy_buffering off;  # tùy chọn, đôi khi giúp nhanh hơn
          '';
        };

      };

      "admin.autocareflow.com" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:30881";  # k3s NodePort - admin (Laravel)
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host              $host;
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host  $host;
            proxy_set_header X-Forwarded-Port  $server_port;

            # Giúp tránh redirect sai port hoặc scheme
            proxy_redirect off;
            proxy_buffering off;  # tùy chọn, đôi khi giúp nhanh hơn
          '';
        };

      };
      "autocareflow.com" = {
        globalRedirect = "www.autocareflow.com";
      };
      "www.autocareflow.com" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:30281";  # k3s NodePort - FE  (nodejs)
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host              $host;
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host  $host;
            proxy_set_header X-Forwarded-Port  $server_port;

            # Giúp tránh redirect sai port hoặc scheme
            proxy_redirect off;
            proxy_buffering off;  # tùy chọn, đôi khi giúp nhanh hơn
          '';
        };

      };
      "backlog.crazyzo.com" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:3002";  
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host              $host;
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host  $host;
            proxy_set_header X-Forwarded-Port  $server_port;

            # Giúp tránh redirect sai port hoặc scheme
            proxy_redirect off;
            proxy_buffering off;  # tùy chọn, đôi khi giúp nhanh hơn
          '';
        };

      };
    };
  };

  systemd.services.homelan-autostart = {
    description = "Homelab Auto Start Script";
    after = [ "docker.service" "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/bash /home/okmuc216/nixos-config/homelan-start.sh";
      Type = "oneshot";
      RemainAfterExit = true;
      User = "okmuc216";
      Environment = [
        "PATH=/run/current-system/sw/bin:/usr/bin:/bin"
      ];
    };
  };

}
