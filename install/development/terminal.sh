#!/bin/bash

echo "installing terminal stuff"

os=$(uname)

core_packages=(
  zsh
  tmux
  fzf
  stow
  ripgrep
  fd
  bat
  jq
  curl
  wget
  git
  htop
  tree
  grep
)
core_packages_macos=(
  gawk
  gnu-sed
)
core_packages_linux=(
  gawk
  sed
)
optional_packages=(
  zoxide
  eza
  mise
  docker
  lazydocker
  lazygit
  gdu
  gh
  try
)

install_with_brew() {
  brew install "$@"
}

install_with_yay() {
  yay -S --noconfirm --needed "$@"
}

if [[ "$os" == "Darwin" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "installing homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  echo "installing core"
  install_with_brew "${core_packages[@]}" "${core_packages_macos[@]}"

  echo "installing optional tools"
  brew install --cask docker
  brew tap tobi/try https://github.com/tobi/try # registering try package
  install_with_brew "${optional_packages[@]}"

elif [[ "$os" == "Linux" ]]; then
  echo "installing core"
  install_with_yay "${core_packages[@]}" "${core_packages_linux[@]}"

  echo "installing optional tools"
  install_with_yay "${optional_packages[@]}"

else
  echo "Unsupported operating system"
fi
