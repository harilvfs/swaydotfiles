<h1 align="center">SwayWM</h1>

<p align="center"><strong>I've added a setup script for Sway Dependencies Installation. If you encounter any issues, please feel free to submit an issue or Contact us <a href="mailto:harilvfs@chalisehari.com.np">harilvfs@chalisehari.com.np</a></strong>

<h3 align="center">Desktop</h3>
<p align="center">
<a> <img src="https://github.com/harilvfs/assets/blob/main/images/IMG_20240706_232523.png" alt="Garuda Sway"> </a>
</p>

> [!IMPORTANT]
> The installation script is for `Arch` or `Arch-based systems` Report any bugs by submitting an issue.

<h2>🚀 Quick Start</h2>

<h3>Run the Setup Script</h3>
<p>This script is designed to install all the necessary dependencies for your Sway setup.</p>

```bash
bash <(curl -L https://raw.githubusercontent.com/harilvfs/swaydotfiles/refs/heads/main/setup.sh)
```

<p><strong>What it does:</strong></p>
<ul>
  <li>Installs all required dependencies for the dotfiles</li>
  <li>Applies the CyberEXS GRUB theme</li>
  <li>Updates GRUB settings based on your system (Debian/Arch)</li>
</ul>

<h3>2. Manually Copy Dotfiles</h3>
<p>To finalize the setup, manually clone the repository and copy the dotfiles to your <code>~/.config</code> directory:</p>

```bash
git clone https://github.com/harilvfs/swaydotfiles
cd swaydotfiles/
cp -r * ~/.config
```

<p>This ensures that your Sway setup will have the proper configurations in place.</p>

<p align="center"><strong>Grub</strong></p>
<p align="center">
  <a><img src="https://github.com/Jacksaur/Gorgeous-GRUB/blob/main/Images/CyberEXS.png" alt="CyberEXS GRUB"></a>
</p>

<p align="center"><strong>Wofi From Garuda Sway</strong> </p>
<p align="center">
  <a><img src="https://github.com/harilvfs/assets/blob/main/images/swappy-20240706-232843.png" alt="Wofi"></a>
</p>

<h3>🎨 Credits</h3>
<ul>
  <li>Wofi theme inspiration and configuration was adapted from <a href="https://github.com/yurihikari/garuda-hyprdots">yurihikari's garuda-hyprdots</a>.</li>
</ul>

<h2>💡 Customization</h2>
<p>Feel free to tweak the configuration files to suit your preferences. You’ll find them in the following locations:</p>
<ul>
  <li><strong>Sway Config:</strong> <code>~/.config/sway/config</code></li>
  <li><strong>Waybar Config:</strong> <code>~/.config/waybar/config</code></li>
  <li><strong>Other Dotfiles:</strong> <code>~/.config/*</code></li>
</ul>


