#!/bin/bash

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
 Installing dependencies
echo -e "\033[1;32mInstalling dependencies...\033[0m"
sudo pacman -S fastfetch fish foot nwg-drawer swappy sway swaylock swayr waybar --noconfirm

# Cloning sway configuration repository
echo -e "\033[1;32mCloning sway configuration repository...\033[0m"
git clone https://github.com/aayushx402/sway
cd sway

# Copying configuration files to ~/.config
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

# Updating GRUB configuration
echo -e "\033[1;32mUpdating GRUB configuration...\033[0m"
sudo bash -c 'cat /dev/null > /etc/default/grub'  # Clear existing GRUB config
sudo curl -o /etc/default/grub https://raw.githubusercontent.com/aayushx402/sway/main/grub%20.cofig

# Applying CyberEXS GRUB theme
echo -e "\033[1;32mApplying CyberEXS GRUB theme...\033[0m"
git clone https://github.com/HenriqueLopes42/themeGrub.CyberEXS
sudo mkdir -p /usr/share/grub/themes/CyberEXS
sudo mv themeGrub.CyberEXS/* /usr/share/grub/themes/CyberEXS/

# Notify the user
echo -e "\033[1;34mConfiguration applied! Enjoy your customized Sway setup!\033[0m"

