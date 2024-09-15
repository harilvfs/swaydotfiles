<h1 align="center">SwayWM Setup 🚀</h1>

<p align="center"><strong>I've added a setup script for Sway Dependencies Installation. If you encounter any issues, please feel free to submit an issue or <a href="mailto:aayushchalise8@gmail.com">contact me</a></strong>


> [!IMPORTANT]
> The installation script is for Arch or Arch-based systems. Report any bugs by submitting an issue.

<h2 align="center">Garuda Sway</h2>
<p align="center">
  <a href="/" target="_blank" rel="noreferrer"><img src="https://github.com/aayushx402/Linux-Background/blob/main/IMG_20240706_232523.png" alt="Garuda Sway"></a>
</p>

<h2>🚀 Quick Start</h2>

<h3>1. Run the Setup Script</h3>
<p>This script is designed to install all the necessary dependencies for your Sway setup. First, make the script executable, and then run it:</p>

<pre><code>chmod +x setup.sh
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

<h2 align="center">Grub</h2>
<p align="center">
  <a href="/" target="_blank" rel="noreferrer"><img src="https://github.com/Jacksaur/Gorgeous-GRUB/blob/main/Images/CyberEXS.png" alt="CyberEXS GRUB"></a>
</p>

<h3>3. Enjoy Your New Setup</h3>
<p>Log out, and log back into Sway to enjoy your newly configured environment. The minimalism and efficiency await you!</p>

<h2 align="center">Wofi</h2>
<p align="center">
  <a href="/" target="_blank" rel="noreferrer"><img src="https://github.com/aayushx402/Linux-Background/blob/main/swappy-20240706-232843.png" alt="Wofi"></a>
</p>

<h2>💡 Customization</h2>
<p>Feel free to tweak the configuration files to suit your preferences. You’ll find them in the following locations:</p>
<ul>
  <li><strong>Sway Config:</strong> <code>~/.config/sway/config</code></li>
  <li><strong>Waybar Config:</strong> <code>~/.config/waybar/config</code></li>
  <li><strong>Other Dotfiles:</strong> <code>~/.config/*</code></li>
</ul>

<h2>📜 License</h2>
<p>This project does not have a formal license. You are free to use it at your own discretion.</p>

<h2>🎉 Contribute</h2>
<p>Found a bug or have an idea for a feature? Feel free to open an issue or submit a pull request.</p>

<hr>
<p>Enjoy your slick and minimal Sway setup! 🚀</p>
