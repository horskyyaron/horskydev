#!/bin/bash


echo "removing old neovim directories"
rm -rf $HOME/.local/share/nvim/
rm -rf $HOME/.cache/nvim/

echo "installing neovim from source"

os=$(uname)
neovim_dir="$HOME/.local/share/neovim"

build_packages_macos=(
    ninja
    cmake
    gettext
    curl
    git
)
build_packages_linux=(
    base-devel
    cmake
    ninja
    curl
    git
    gettext
)

install_with_brew() {
    brew install "$@"
}

install_with_yay() {
    yay -S --noconfirm --needed "$@"
}

if [[ "$os" == "Darwin" ]]; then
    if ! xcode-select -p >/dev/null 2>&1; then
        echo "installing xcode command line tools"
        xcode-select --install
        echo "rerun this step after the install completes"
        exit 1
    fi

    if ! command -v brew >/dev/null 2>&1; then
        echo "homebrew is required to install neovim build dependencies"
        exit 1
    fi

    install_with_brew "${build_packages_macos[@]}"
elif [[ "$os" == "Linux" ]]; then
    if ! command -v yay >/dev/null 2>&1; then
        echo "yay is required to install neovim build dependencies"
        exit 1
    fi

    install_with_yay "${build_packages_linux[@]}"
else
    echo "Unsupported operating system"
    exit 1
fi

if [[ -d "$neovim_dir/.git" ]]; then
    echo "updating neovim source"
    git -C "$neovim_dir" fetch --all --prune
    git -C "$neovim_dir" checkout stable
    git -C "$neovim_dir" pull --ff-only
else
    echo "cloning neovim source"
    git clone --branch stable https://github.com/neovim/neovim.git "$neovim_dir"
fi

if ! cd "$neovim_dir"; then
    echo "failed to enter neovim source directory"
    exit 1
fi

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
