# nixos
cp /etc/nixos/configuration.nix ~/nixos-config/
cp /etc/nixos/hardware-configuration.nix ~/nixos-config/

sudo mv /etc/nixos /etc/nixos.backup
sudo ln -s ~/nixos-config /etc/nixos

# jet
jetbrains-toolbox &

