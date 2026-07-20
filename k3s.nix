# PC-specific configuration
{ config, pkgs, ... }:

# To customize for PC, edit this file as needed.
{
  networking.firewall = {
    allowedTCPPorts = [
      6443  # k3s API server
      80    # Traefik HTTP
      443   # Traefik HTTPS
    ];
    # Flannel/CNI interfaces được trust hoàn toàn
    trustedInterfaces = [ "cni0" "flannel.1" "lo" "tailscale0" ];
    # Tắt reverse path check — k3s pod traffic sẽ bị drop nếu không có dòng này
    checkReversePath = false;

    # Mở NodePort MySQL (30306) chỉ qua interface Tailscale,
    # để Navicat/... connect được từ xa mà không lộ port ra LAN/Internet.
    interfaces."tailscale0".allowedTCPPorts = [ 30306 ];
  };

  # NixOS 25.05 dùng nftables mặc định, nhưng k3s kube-proxy dùng iptables.
  # Tắt nftables để dùng iptables-legacy, tránh conflict rule NAT cho ClusterIP.
  networking.nftables.enable = false;

  # Load iptables kernel modules cần thiết cho k3s service routing
  boot.kernelModules = [
    "ip_tables"
    "iptable_nat"
    "iptable_filter"
    "xt_conntrack"
  ];

  services.k3s = {
    enable = true;
    role   = "server";
    extraFlags = toString [ "--write-kubeconfig-mode=644" ];
  };

  environment.systemPackages = [ pkgs.k3s ];

  security.sudo.extraRules = [
    {
      users = [ "okmuc216" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/k3s";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
