#!/bin/bash

# Function to ask if the user wants to install the pkg
function ask() {
    read -p "$1 [y/n]" response
    [ -z "$response" ] || [ "$response" = "y" ]
}

## VARIABLES

# Path to the file containing the list of packages to ask the user about
pkg_list="pkg_list.txt"
# Path to the temporary file where the list of packages to install will be stored
pkg_install="pkg_install.txt"
# Path to the file containing the list of configuration directories to manage with stow
stow_files="stow_files.txt"
# URL of the dotfiles repository to clone
dotfiles_repo="https://github.com/ilBuso/.dotfiles.git"
# Path where the dotfiles repository will be cloned
dotfiles_dir="$HOME/.dotfiles"
# Path where configuration files will be stowed
config_dir="$HOME/.config"

# Ensure stow and git are installed
if ! command -v stow &> /dev/null; then
    echo "[ERROR]: stow is not installed. Please install stow and rerun the script."
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "[ERROR]: git is not installed. Please install git and rerun the script."
    exit 1
fi

# Ensure the pkg_install file is empty
: > "$pkg_install"

# Ask for pkgs to install
while read -r pkg; do
    if ask "Do you want to install ${pkg}?"; then
        echo "$pkg" >> "$pkg_install"
    fi
done < "$pkg_list"

# Install pkgs
if ask "Do you want to proceed with the installation?"; then
    while read -r pkg; do
        pamac install "$pkg"
    done < "$pkg_install"
fi

# Download .dotfile repo
echo "Updating config files..."
git clone "$dotfiles_repo" "$dotfiles_dir"

# Usa stow to set the config files
while read -r conf; do
    if [ -e "$config_dir/$conf" ]; then
        rm -rf "$config_dir/$conf"
    fi
    stow --dir="$dotfiles_dir" --target="$config_dir" "$conf"
done < "$stow_files"
