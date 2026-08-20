# Homelab server-specific configuration (nginx reverse proxy, cloudflared,
# k3s, remote access). Not used on laptop/pc.
{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./hardware-configuration.nix
    ./k3s.nix
  ];

  networking.hostName = "homelap";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  services.getty.autologinUser = "okmuc216";

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
  services.tailscale.extraUpFlags = [ "--ssh" ];
  services.openssh.enable = true;

  users.users.quangbeo216 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # k3s needs the legacy cgroup hierarchy + iptables-based cgroup driver.
  boot.kernelParams = [ "systemd.unified_cgroup_hierarchy=1" ];
  virtualisation.docker.extraOptions = "--experimental --exec-opt native.cgroupdriver=systemd";
  systemd.services.docker.serviceConfig = {
    PrivateTmp = false;
    ProtectHome = false;
    MountFlags = "shared";
  };

  networking.extraHosts = ''
    192.168.88.186 phpmyadmin.local
  '';

  networking.firewall.allowedTCPPorts = [
    22   # SSH
    443  # Nginx HTTPS
    3306 # MySQL
    5432 # Postgres
  ];

  services.nginx = {
    enable = true;

    virtualHosts = {
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

  # Kept for reference, currently unused (postgres runs in a container instead):
  # services.postgresql = {
  #   enable = true;
  #   package = pkgs.postgresql_15;
  #   dataDir = "/var/lib/postgresql/data";
  #   initialScript = null;
  #   settings = {
  #     listen_addresses = pkgs.lib.mkForce "*";
  #     port = 5432;
  #     max_connections = 100;
  #     shared_buffers = "128MB";
  #   };
  #   authentication = ''
  #     local   all             postgres                                peer
  #     host    all             all             172.21.0.0/16         md5
  #   '';
  # };
}
