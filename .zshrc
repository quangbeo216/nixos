# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Powerlevel10k theme (từ nixos-config: environment.systemPackages -> zsh-powerlevel10k)
# Guard bằng -r phòng khi chưa `nixos-rebuild switch` sau khi thêm package
[[ -r /run/current-system/sw/share/zsh-powerlevel10k/powerlevel10k.zsh-theme ]] &&
  source /run/current-system/sw/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

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
if command -v dart >/dev/null 2>&1; then
  export DART_SDK_HOME=$(dirname $(dirname $(which dart)))/lib/dart
  export PATH=$DART_SDK_HOME/bin:$PATH
fi
export PATH="$HOME/.local/bin:$PATH"

# Enable colored output
autoload -U colors && colors
setopt prompt_subst

# Aliases hay dùng
alias ll='ls -lah --color=auto'
alias gs='git status'
alias gl='git log --oneline --graph --decorate'
alias ..='cd ..'
alias ...='cd ../..'

# History
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# zsh-autosuggestions (gợi ý lệnh từ history khi gõ)
[[ -r /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
  source /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting (phải source SAU CÙNG, sau mọi plugin/widget khác)
[[ -r /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
  source /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
