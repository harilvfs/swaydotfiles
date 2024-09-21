<h1 align="center">SwayWM Setup 🚀</h1>

<p align="center"><strong>I've added a setup script for Sway Dependencies Installation. If you encounter any issues, please feel free to submit an issue or <a href="mailto:aayushchalise8@gmail.com">contact me</a></strong>

<h2 align="center">Garuda Sway</h2>
<p align="center">
  <a href="/" target="_blank" rel="noreferrer"><img src="https://github.com/aayushx402/Linux-Background/blob/main/IMG_20240706_232523.png" alt="Garuda Sway"></a>
</p>

> [!IMPORTANT]
> The installation script is for Arch or Arch-based systems. Report any bugs by submitting an issue.

<h2>🚀 Quick Start</h2>

<h3>1. Run the Setup Script</h3>
<p>This script is designed to install all the necessary dependencies for your Sway setup. First, make the script executable, and then run it:</p>

<pre><code>git clone https://github.com/aayushx402/sway
chmod +x setup.sh
./setup.sh</code></pre>

<p><strong>What it does:</strong></p>
<ul>
  <li>Installs all required dependencies for the dotfiles</li>
  <li>Applies the CyberEXS GRUB theme</li>
  <li>Updates GRUB settings based on your system (Debian/Arch)</li>
</ul>

<h3>2. Manually Copy Dotfiles</h3>
<p>To finalize the setup, manually clone the repository and copy the dotfiles to your <code>~/.config</code> directory:</p>

<pre><code>git clone https://github.com/aayushx402/sway
cd sway
cp -r * ~/.config/</code></pre>

<p>This ensures that your Sway setup will have the proper configurations in place.</p>

<p align="center"><strong>Grub</strong></p>
<p align="center">
  <a href="/" target="_blank" rel="noreferrer"><img src="https://github.com/Jacksaur/Gorgeous-GRUB/blob/main/Images/CyberEXS.png" alt="CyberEXS GRUB"></a>
</p>

<p align="center"><strong>Wofi From Garuda Sway</strong> </p>
<p align="center">
  <a href="/" target="_blank" rel="noreferrer"><img src="https://github.com/aayushx402/Linux-Background/blob/main/swappy-20240706-232843.png" alt="Wofi"></a>
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


