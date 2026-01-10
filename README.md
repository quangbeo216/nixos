# nixos
cp /etc/nixos/configuration.nix ~/nixos-config/
cp /etc/nixos/hardware-configuration.nix ~/nixos-config/

sudo mv /etc/nixos /etc/nixos.backup
sudo ln -s ~/nixos-config /etc/nixos

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