# Set PATH cho Nix profile (nếu dùng nix profile)
if [ -d "$HOME/.nix-profile/bin" ]; then
  export PATH="$HOME/.nix-profile/bin:$PATH"
fi

# Java JDK 17 (nếu cài qua Nix)
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
export PATH="$JAVA_HOME/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

# Flutter SDK (nếu cài bằng Nix)
export PATH="$HOME/.nix-profile/bin:$PATH"

# Alias tiện dụng
alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'

# Enable colored output
autoload -U colors && colors

# Prompt đơn giản, hiển thị user@host và thư mục hiện tại
PROMPT='%F{green}%n@%m %F{blue}%~ %# %f'

# Nếu bạn dùng oh-my-zsh, uncomment dòng dưới
 source $HOME/.oh-my-zsh/oh-my-zsh.sh
 ZSH_THEME="agnoster"
 
 export DART_SDK_HOME=$(dirname $(dirname $(which dart)))/lib/dart
export PATH=$DART_SDK_HOME/bin:$PATH
