# Homelap-specific configuration
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  # ...existing code from configuration.nix...
}
