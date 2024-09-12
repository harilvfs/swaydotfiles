#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail  # Return the exit status of the last command in the pipe that failed

echo -ne "
  ███████╗██╗    ██╗ █████╗ ██╗   ██╗
  ██╔════╝██║    ██║██╔══██╗╚██╗ ██╔╝
  ███████╗██║ █╗ ██║███████║ ╚████╔╝ 
  ╚════██║██║███╗██║██╔══██║  ╚██╔╝  
  ███████║╚███╔███╔╝██║  ██║   ██║   
  ╚══════╝ ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝   
                                   
-----------------------------------------
         Sway Dotfiles Setup
-----------------------------------------
"

echo -e "\033[1;32mInstalling dependencies...\033[0m"
if ! sudo pacman -S --noconfirm sway wlroots fastfetch fish foot nwg-drawer swappy swaylock swayr waybar wayland pango cairo gdk-pixbuf2 json-c scdoc meson ninja pcre2 gtk-layer-shell jsoncpp libsigc++ libdbusmenu-gtk3 libxkbcommon fmt spdlog glibmm gtkmm3 alsa-utils pulseaudio libnl iw wob swaybg swayidle swaylock alacritty wofi wl-clipboard grim slurp mako ttf-nerd-fonts-symbols-mono; then
    echo -e "\033[1;31mFailed to install dependencies\033[0m"
    exit 1
fi

echo -e "\033[1;32mCloning sway configuration repository...\033[0m"
if ! git clone https://github.com/aayushx402/sway; then
    echo -e "\033[1;31mFailed to clone sway repository\033[0m"
    exit 1
fi
cd sway

echo -e "\033[1;32mCopying configuration files...\033[0m"
for dir in *; do
    if [ -d "$dir" ]; then
        if [ -d "$HOME/.config/$dir" ]; then
            echo -e "\033[1;33mReplacing existing $dir configuration...\033[0m"
            rm -rf "$HOME/.config/$dir"
        fi
        cp -r "$dir" "$HOME/.config/"
    fi
done

echo -e "\033[1;32mApplying CyberEXS GRUB theme...\033[0m"
if ! git clone https://github.com/HenriqueLopes42/themeGrub.CyberEXS; then
    echo -e "\033[1;31mFailed to clone GRUB theme repository\033[0m"
    exit 1
fi
cd themeGrub.CyberEXS
sudo mkdir -p /usr/share/grub/themes/CyberEXS
sudo mv * /usr/share/grub/themes/CyberEXS/

echo -e "\033[1;32mSetting GRUB theme...\033[0m"
if ! echo 'GRUB_THEME="/usr/share/grub/themes/CyberEXS/theme.txt"' | sudo tee -a /etc/default/grub; then
    echo -e "\033[1;31mFailed to set GRUB theme\033[0m"
    exit 1
fi

if [ -f /etc/debian_version ]; then
    echo -e "\033[1;32mUpdating GRUB for Debian-based systems...\033[0m"
    if ! sudo update-grub; then
        echo -e "\033[1;31mFailed to update GRUB for Debian-based systems\033[0m"
        exit 1
    fi
elif [ -f /etc/arch-release ]; then
    echo -e "\033[1;32mUpdating GRUB for Arch-based systems...\033[0m"
    if ! sudo grub-mkconfig -o /boot/grub/grub.cfg; then
        echo -e "\033[1;31mFailed to update GRUB for Arch-based systems\033[0m"
        exit 1
    fi
else
    echo -e "\033[1;33mUnknown system type. Skipping GRUB update.\033[0m"
fi

echo -e "\033[1;34mConfiguration applied! Enjoy your customized Sway setup!\033[0m"

