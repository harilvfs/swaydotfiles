#!/bin/bash

set -e  
set -o pipefail 

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

echo -e "\033[1;32mCloning Sway dotfiles...\033[0m"
if ! git clone https://github.com/harilvfs/swaydotfiles /tmp/swaydotfiles; then
    echo -e "\033[1;31mFailed to clone Sway dotfiles repository\033[0m"
    exit 1
fi

cd /tmp/swaydotfiles
echo -e "\033[1;32mMoving Sway dotfiles to ~/.config...\033[0m"
if ! mv * ~/.config/; then
    echo -e "\033[1;31mFailed to move Sway dotfiles to ~/.config\033[0m"
    exit 1
fi

echo -e "\033[1;32mCloning CyberEXS GRUB theme repository...\033[0m"
if ! git clone https://github.com/HenriqueLopes42/themeGrub.CyberEXS; then
    echo -e "\033[1;31mFailed to clone GRUB theme repository\033[0m"
    exit 1
fi
cd themeGrub.CyberEXS

echo -e "\033[1;32mInstalling CyberEXS GRUB theme...\033[0m"
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

echo -e "\033[1;34mSway Dotfiles setup and CyberEXS GRUB theme applied successfully!\033[0m"
