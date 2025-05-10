<p align="center">
  <img src="https://raw.githubusercontent.com/harilvfs/assets/refs/heads/main/sway/swaywmicon.png" width="70" />
</p>

<div align="center">

# `SwayWM Dotfiles`

</div>

<div align="center">
  
> **A clean and functional `SwayWM` setup inspired by 
  <a href="https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-sway-settings/-/tree/master">Garuda Sway Dotfiles**</a>.
</div>

<div align="center">
  <img src="http://raw.githubusercontent.com/harilvfs/assets/refs/heads/main/sway/swappy-20250209-011004.png" />
</div>


> **🚀 Features**
> - Minimal and aesthetic **`SwayWM`** configuration  
> - Custom **`Waybar`** with useful modules
> - Preconfigured **`Keybindings`** for better workflow  
> - **`Autotiling`** support for automatic window management  
> - Optimized for **`Wayland`**  
> - Lightweight and efficient  

<br>

> [!CAUTION]
> **I am NOT `responsible` for any system issues or data loss.**  
> Please review the setup script before running it!  

<br>

> 🛠️ Installation  
>
> 🔹 **Automatic Setup (For Arch Linux)**  
> If you're using **`Arch Linux`**, you can run the automated setup script:  
>
> ```bash
> bash <(curl -L https://chalisehari.com.np/swaywm)
> ```

> [!IMPORTANT]
> **Make sure to install `fzf` and `figlet` before running the script!**  
> They are required for the interactive prompts.  
> ```bash
> sudo pacman -S fzf figlet --noconfirm
> ```

<br>

> [!TIP]
> If you want the same wallpapers, clone my wallpaper repository:
> ```bash
> git clone https://github.com/harilvfs/wallpapers ~/Pictures
> ```
>
> Then apply wallpapers using **Azote**.

<br>

> [!NOTE]
> **📌 Dependencies**
>
> Make sure you install the required `dependencies` before proceeding.
>
> ✅ **Core Dependencies (Install via `pacman`)**
> 
> ```bash
> sudo pacman -S fastfetch fish foot nwg-drawer bluetui ttf-jetbrains-mono ttf-jetbrains-mono-nerd swappy swaylock waybar pango cairo gdk-pixbuf2 json-c scdoc meson ninja pcre2 gtk-layer-shell jsoncpp libsigc++ libdbusmenu-gtk3 libxkbcommon fmt spdlog glibmm gtkmm3 alsa-utils pipewire-pulse libnl iw wob swaybg swayidle fuzzel otf-font-awesome ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-ubuntu-font-family wl-clipboard grim slurp mako blueberry pamixer pavucontrol gnome-keyring polkit-gnome cliphist wl-clipboard autotiling gtklock swayidle xdg-desktop-portal xdg-desktop-portal-wlr xorg-xhost sddm kvantum qt5-wayland qt6-wayland dex wf-recorder nwg-hello blueman bluez bluez-libs bluez-qt bluez-qt5 bluez-tools bluez-utils alacritty kitty --noconfirm
> ```
>
> 📦 **AUR Packages (Install via `yay` or `paru`)**
> ```bash
> yay -S swayfx waybar-module-pacman-updates-git wlroots-git --noconfirm
> ```
> or
> ```bash
> paru -S swayfx waybar-module-pacman-updates-git wlroots-git --noconfirm
> ```

### ⌨️ Keybindings  
> [!TIP]  
> Default Keybindings for essential applications:
> 
> - **Terminal:** `Super + T`  
> - **Launcher:** `Super + D`  
> - **File Manager:** `Super + E`  
>
> Check more keybindings **[here](https://github.com/harilvfs/swaydotfiles/blob/main/sway/config.d/default)**.  

### 📜 Additional Notes  
> [!NOTE]
> This setup is optimized for **`Arch Linux`**, but might work on other distros with some modifications.  
> Ensure you have **`Wayland-compatible`** applications for the best experience.  

### 🎯 Related Projects  
> [!TIP]  
> Want a better **`Bash prompt` , `Zsh setup` , or other system enhancements**?
> 
> Check out my **`Carch Project`**:  
> **🔗 [Carch - Arch & Fedora Linux Automation](https://github.com/harilvfs/carch)**  

### 🎯 Credits  
> - **Inspired by** **[Garuda Sway Dotfiles](https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-sway-settings/-/tree/master)**  
> - **Maintained by** **[@harilvfs](https://github.com/harilvfs)**

