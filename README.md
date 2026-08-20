# nixos

## Multi-machine layout
Shared settings live in `common.nix`. Each machine only keeps what's
different (hostname, bootloader, packages, services) in its own file:
`laptop.nix`, `pc.nix`, `homelap.nix`. All three import `common.nix` +
`hardware-configuration.nix`.

`configuration.nix` and `hardware-configuration.nix` are gitignored — they're
per-machine and set up once, not shared through git.

## First-time setup on a new/existing machine
cp /etc/nixos/hardware-configuration.nix ~/nixos-config/

sudo mv /etc/nixos /etc/nixos.backup
sudo ln -s ~/nixos-config /etc/nixos

# Create configuration.nix for THIS machine — it just imports the right
# host file. Pick exactly one:

cat > ~/nixos-config/configuration.nix <<'EOF'   # laptop
{ config, pkgs, ... }:
{ imports = [ ./laptop.nix ]; }
EOF

cat > ~/nixos-config/configuration.nix <<'EOF'   # desktop PC
{ config, pkgs, ... }:
{ imports = [ ./pc.nix ]; }
EOF

cat > ~/nixos-config/configuration.nix <<'EOF'   # homelab server
{ config, pkgs, ... }:
{ imports = [ ./homelap.nix ]; }
EOF

# jet
jetbrains-toolbox &


# kitty
~/.config/kitty/kitty.conf
mkdir -p ~/.config/kitty
touch ~/.config/kitty/kitty.conf
mkdir -p ~/nixos-config/.config/kitty
cp ~/.config/kitty/kitty.conf ~/nixos-config/.config/kitty/
rm -rf ~/.config/kitty
ln -s ~/nixos-config/.config/kitty ~/.config/kitty



# Tạo thư mục để chứa Zsh config
mkdir -p ~/nixos-config

# Copy file .zshrc vào repo
cp ~/.zshrc ~/nixos-config/.zshrc

# Nếu dùng Oh My Zsh, copy cả thư mục
cp -r ~/.oh-my-zsh ~/nixos-config/.oh-my-zsh


# Xóa file gốc (nếu có)
rm -f ~/.zshrc
rm -rf ~/.oh-my-zsh

# Liên kết từ repo sang home
ln -s ~/nixos-config/.zshrc ~/.zshrc
ln -s ~/nixos-config/.oh-my-zsh ~/.oh-my-zsh



ln -s  ~/nixos-config/.gitconfig ~/.gitconfig 

ln -s  ~/nixos-config/.tmux.conf ~/.tmux.conf