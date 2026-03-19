#!/usr/bin/env bash

# This Script is Currently not compatible with Fedora. Only supported for Arch-based systems only.

clear

GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
BOLD="\033[1m"
TEAL="\e[38;2;129;200;190m"
NC="\033[0m"

print_message() {
    echo -e "${1}${2}${NC}"
}

command_exists() {
    command -v "$1" &>/dev/null
}

FZF_COMMON="--layout=reverse \
            --border=bold \
            --border=rounded \
            --margin=5% \
            --color=dark \
            --info=inline \
            --header-first \
            --bind change:top"

fzf_confirm() {
    local prompt="$1"
    local options=("Yes" "No")
    local selected
    selected=$(printf "%s\n" "${options[@]}" | fzf ${FZF_COMMON} \
                                                     --height=40% \
                                                     --prompt="$prompt " \
                                                     --header="Confirm" \
                                                     --pointer="➤" \
                                                     --color='fg:white,fg+:green,bg+:black,pointer:green')

    if [[ "$selected" == "Yes" ]]; then
        return 0
    else
        return 1
    fi
}

install_aur_helper() {
    if ! command -v yay >/dev/null 2>&1 && ! command -v paru >/dev/null 2>&1; then
        print_message "$GREEN" "Installing yay as AUR helper..."

        sudo pacman -S --needed base-devel git --noconfirm

        local temp_dir
        temp_dir=$(mktemp -d) || { print_message "$RED" "Failed to create temporary directory"; return 1; }
        cd "$temp_dir" || { print_message "$RED" "Failed to enter temporary directory"; return 1; }

        git clone https://aur.archlinux.org/yay.git
        cd yay || { print_message "$RED" "Failed to enter yay directory"; return 1; }
        makepkg -si --noconfirm

        cd "$OLDPWD" || true
        rm -rf "$temp_dir"

        if command -v yay >/dev/null 2>&1; then
            print_message "$GREEN" "yay installed successfully."
        else
            print_message "$RED" "Failed to install yay."
            return 1
        fi
    else
        if command -v yay >/dev/null 2>&1; then
            print_message "$YELLOW" "AUR helper (yay) already installed."
        elif command -v paru >/dev/null 2>&1; then
            print_message "$YELLOW" "AUR helper (paru) already installed."
        fi
    fi
}

install_packages() {
    local packages=("$@")
    local missing_pkgs=()

    for pkg in "${packages[@]}"; do
        if ! pacman -Qq "$pkg" &>/dev/null; then
            missing_pkgs+=("$pkg")
        fi
    done

    if [ ${#missing_pkgs[@]} -ne 0 ]; then
        print_message "$GREEN" "Installing missing packages: ${missing_pkgs[*]}"
        sudo pacman -S --needed "${missing_pkgs[@]}"
    else
        print_message "$YELLOW" "All required packages are already installed."
    fi
}

install_aur_packages() {
    local packages=("$@")
    local missing_pkgs=()
    local aur_helper

    if command -v yay >/dev/null 2>&1; then
        aur_helper="yay"
    elif command -v paru >/dev/null 2>&1; then
        aur_helper="paru"
    else
        print_message "$RED" "No AUR helper found. Please install yay or paru first."
        return 1
    fi

    for pkg in "${packages[@]}"; do
        if ! $aur_helper -Qq "$pkg" &>/dev/null; then
            missing_pkgs+=("$pkg")
        fi
    done

    if [ ${#missing_pkgs[@]} -ne 0 ]; then
        print_message "$GREEN" "Installing missing AUR packages: ${missing_pkgs[*]}"
        $aur_helper -S "${missing_pkgs[@]}"
    else
        print_message "$YELLOW" "All required AUR packages are already installed."
    fi
}

install_pokemon_colorscripts() {
    print_message "${TEAL}" "Installing Pokémon Color Scripts..."

    if command -v pokemon-colorscripts >/dev/null 2>&1; then
        print_message "$YELLOW" "Pokémon Color Scripts already installed."
        return 0
    fi

    local aur_helper=""
    if command -v yay >/dev/null 2>&1; then
        aur_helper="yay"
    elif command -v paru >/dev/null 2>&1; then
        aur_helper="paru"
    else
        print_message "$RED" "No AUR helper found. Installing yay first..."
        install_aur_helper
        if command -v yay >/dev/null 2>&1; then
            aur_helper="yay"
        else
            print_message "$RED" "Failed to install AUR helper."
            return 1
        fi
    fi

    print_message "$CYAN" "Installing Pokémon Color Scripts from AUR..."
    if $aur_helper -S --noconfirm pokemon-colorscripts-git; then
        print_message "$GREEN" "Pokémon Color Scripts installed successfully!"
        print_message "${TEAL}" "You can now use 'pokemon-colorscripts -r' to display a random Pokémon!"
    else
        print_message "$RED" "Failed to install Pokémon Color Scripts."
        return 1
    fi
}

manage_dotfiles() {
    local repo_url="$1"
    local repo_dir="$2"
    local backup_dir="$3"

    if [ -d "$repo_dir" ]; then
        if fzf_confirm "Existing dotfiles detected. Overwrite?"; then
            rm -rf "$repo_dir"
        else
            print_message "$YELLOW" "Skipping dotfiles cloning."
            return
        fi
    fi

    git clone "$repo_url" "$repo_dir"

    mkdir -p "$backup_dir"

    for config in "$repo_dir"/*; do
        local config_name
        config_name=$(basename "$config")
        if [ -e "$HOME/.config/$config_name" ]; then
            if fzf_confirm "Existing config $config_name detected. Backup?"; then
                mv "$HOME/.config/$config_name" "$backup_dir/"
            fi
        fi
        cp -r "$config" "$HOME/.config/"
    done

    local home_files=(".azotebg" ".gtkrc-2.0" ".profile")
    for f in "${home_files[@]}"; do
        if [ -e "$repo_dir/$f" ]; then
            cp -r "$repo_dir/$f" "$HOME/"
        else
            print_message "$YELLOW" "Optional file $f not found in repo, skipping."
        fi
    done

    if [ -d "$repo_dir/usr/share" ]; then
        print_message "$GREEN" "Copying system-wide files..."
        sudo cp -r "$repo_dir/usr/share" /usr/
    fi
}

manage_themes_icons() {
    local repo_url="$1"
    local target_dir="$2"
    local repo_name
    repo_name=$(basename "$repo_url" .git)
    local temp_dir
    temp_dir=$(mktemp -d) || { print_message "$RED" "Failed to create temporary directory"; return 1; }

    print_message "$CYAN" "Cloning $repo_name into temporary directory..."
    git clone "$repo_url" "$temp_dir/$repo_name" || {
        print_message "$RED" "Failed to clone $repo_name"
        rm -rf "$temp_dir"
        return 1
    }

    mkdir -p "$target_dir"

    print_message "$GREEN" "Copying contents to $target_dir..."
    for item in "$temp_dir/$repo_name"/*; do
        if [ -d "$item" ]; then
            local name
            name=$(basename "$item")
            if [ -d "$target_dir/$name" ]; then
                if fzf_confirm "Existing $name detected in $target_dir. Overwrite?"; then
                    rm -rf "$target_dir/$name"
                else
                    print_message "$YELLOW" "Skipping $name"
                    continue
                fi
            fi
            cp -r "$item" "$target_dir/"
        fi
    done

    rm -rf "$temp_dir"
    print_message "$GREEN" "$repo_name installed to $target_dir"
}

clone_repo_contents() {
    local repo_url="$1"
    local target_dir="$2"
    local repo_name
    repo_name=$(basename "$repo_url" .git)

    mkdir -p "$target_dir"

    print_message "$CYAN" "Cloning $repo_name directly into $target_dir..."
    git clone "$repo_url" "$target_dir" || {
        print_message "$RED" "Failed to clone $repo_name"
        return 1
    }

    print_message "$GREEN" "$repo_name cloned to $target_dir"
}

if ! command -v fzf &> /dev/null; then
    echo -e "${RED}${BOLD}Error: fzf is not installed${NC}"
    echo -e "${YELLOW}Please install fzf before running this script:${NC}"
    echo -e "${CYAN}  • Fedora: ${NC}sudo dnf install fzf"
    echo -e "${CYAN}  • Arch Linux: ${NC}sudo pacman -S fzf"
    exit 1
fi

print_message "${TEAL}" "If the setup fails, please manually use the dotfiles from:
https://github.com/harilvfs/swaydotfiles"

print_message "$YELLOW" "----------------------------------------"

if command -v pacman &>/dev/null; then
   print_message "$GREEN" "Arch Linux detected. Proceeding with setup..."
elif command -v dnf &>/dev/null; then
   print_message "$RED" "Sway setup for Fedora is not finalized due to missing dependencies and runtime errors. Exiting."
   exit 1
else
   print_message "$RED" "Unsupported distribution. Exiting."
   exit 1
fi

REQUIRED_PKGS=(git base-devel make less)
install_packages "${REQUIRED_PKGS[@]}"

install_aur_helper

PACMAN_PKGS=(fastfetch fish foot nwg-drawer bluetui ttf-jetbrains-mono ttf-jetbrains-mono-nerd swappy swaylock waybar pango cairo gdk-pixbuf2 json-c scdoc meson ninja pcre2 gtk-layer-shell jsoncpp libsigc++ libdbusmenu-gtk3 libxkbcommon fmt spdlog glibmm gtkmm3 alsa-utils pipewire-pulse libnl iw wob swaybg swayidle fuzzel otf-font-awesome ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-ubuntu-font-family wl-clipboard grim slurp mako blueberry pamixer pavucontrol gnome-keyring polkit-gnome cliphist wl-clipboard autotiling gtklock swayidle xdg-desktop-portal xdg-desktop-portal-wlr xorg-xhost sddm kvantum qt5-wayland qt6-wayland dex wf-recorder nwg-hello blueman bluez bluez-libs bluez-qt bluez-qt5 bluez-tools bluez-utils alacritty kitty azote xorg-xwayland)
install_packages "${PACMAN_PKGS[@]}"

AUR_PKGS=(swayfx waybar-module-pacman-updates-git wlroots-git)
install_aur_packages "${AUR_PKGS[@]}"

if fzf_confirm "Do you want to install Pokémon Color Scripts? [Fun terminal colors]"; then
    install_pokemon_colorscripts
fi

DOTFILES_REPO="https://github.com/harilvfs/swaydotfiles"
DOTFILES_DIR="$HOME/swaydotfiles"
BACKUP_DIR="$HOME/.swaydotfiles/backup"
manage_dotfiles "$DOTFILES_REPO" "$DOTFILES_DIR" "$BACKUP_DIR"

THEME_REPO="https://github.com/harilvfs/themes"
ICON_REPO="https://github.com/harilvfs/icons"
THEME_DIR="$HOME/.themes"
ICON_DIR="$HOME/.icons"
manage_themes_icons "$THEME_REPO" "$THEME_DIR"
manage_themes_icons "$ICON_REPO" "$ICON_DIR"

if fzf_confirm "Do you want additional wallpapers? [Recommended]"; then
    WALLPAPER_REPO="https://github.com/harilvfs/wallpapers"
    WALLPAPER_DIR="$HOME/Pictures/wallpapers"
    clone_repo_contents "$WALLPAPER_REPO" "$WALLPAPER_DIR"
    print_message "$GREEN" "Wallpapers are located in $WALLPAPER_DIR. Apply them using azote."
fi

is_sddm_installed() {
    if command -v sddm &> /dev/null; then
        return 0
    else
        return 1
    fi
}

install_sddm() {
    print_message "$GREEN" "Installing SDDM..."
    sudo pacman -S --noconfirm sddm
}

SDDM_THEME_VERSION="v1.0.0"
SDDM_THEME_URL="https://github.com/catppuccin/sddm/releases/download/${SDDM_THEME_VERSION}/catppuccin-mocha.zip"

apply_sddm_theme() {
    local theme_dir="/usr/share/sddm/themes/catppuccin-mocha"

    if [ -d "$theme_dir" ]; then
        print_message "$YELLOW" "$theme_dir already exists."
        if fzf_confirm "Do you want to remove the existing theme and continue?"; then
            sudo rm -rf "$theme_dir"
            print_message "$GREEN" "$theme_dir removed."
        else
            print_message "$RED" "$theme_dir not removed, skipping theme application."
            return 1
        fi
    fi

    local temp_dir
    temp_dir=$(mktemp -d) || { print_message "$RED" "Failed to create temporary directory"; return 1; }
    print_message "$CYAN" "Downloading Catppuccin Mocha SDDM theme (${SDDM_THEME_VERSION})..."
    wget "$SDDM_THEME_URL" -O "$temp_dir/catppuccin-mocha.zip" || {
        print_message "$RED" "Failed to download SDDM theme."
        rm -rf "$temp_dir"
        return 1
    }

    unzip "$temp_dir/catppuccin-mocha.zip" -d "$temp_dir" || {
        print_message "$RED" "Failed to unzip SDDM theme."
        rm -rf "$temp_dir"
        return 1
    }

    print_message "$GREEN" "Copying the theme to /usr/share/sddm/themes..."
    sudo cp -r "$temp_dir/catppuccin-mocha" /usr/share/sddm/themes/

    rm -rf "$temp_dir"
}

configure_sddm_theme() {
    print_message "$CYAN" "Configuring sddm.conf to use the Catppuccin Mocha theme..."
    printf "[Theme]\nCurrent=catppuccin-mocha\n" | sudo tee /etc/sddm.conf > /dev/null
}

enable_start_sddm() {
    print_message "$GREEN" "Checking for existing display managers..."

    if command -v gdm &> /dev/null; then
        print_message "$YELLOW" "GDM detected. Removing GDM..."
        sudo systemctl stop gdm
        sudo systemctl disable gdm --now
        sudo pacman -Rns --noconfirm gdm
    fi

    if command -v lightdm &> /dev/null; then
        print_message "$YELLOW" "LightDM detected. Removing LightDM..."
        sudo systemctl stop lightdm
        sudo systemctl disable lightdm --now
        sudo pacman -Rns --noconfirm lightdm
    fi

    if systemctl is-enabled greetd &> /dev/null; then
        print_message "$YELLOW" "Greetd detected. Stopping and disabling Greetd..."
        sudo systemctl stop greetd
        sudo systemctl disable greetd --now
        if pacman -Qq greetd &> /dev/null; then
            print_message "$CYAN" "Removing Greetd package..."
            sudo pacman -Rns --noconfirm greetd
        fi
    fi

    print_message "$GREEN" "Enabling and starting the SDDM service..."
    sudo systemctl enable sddm --now
}

if fzf_confirm "Do you want to install and configure SDDM display manager? [Recommended for login screen]"; then
    if ! is_sddm_installed; then
        install_sddm
    else
        print_message "$YELLOW" "SDDM is already installed."
    fi

    apply_sddm_theme
    configure_sddm_theme
    enable_start_sddm

    print_message "$GREEN" "SDDM theme applied, service started, and configuration updated successfully!"
else
    print_message "$YELLOW" "Skipping SDDM installation and configuration."
fi

print_message "${TEAL}" "Default keybindings: Super+Enter (Terminal), Super+D (App Launcher)"
if command -v pokemon-colorscripts >/dev/null 2>&1; then
    print_message "${TEAL}" "Try 'pokemon-colorscripts -r' for random Pokémon colors!"
fi

print_message "$GREEN" "SwayWM setup complete!"
