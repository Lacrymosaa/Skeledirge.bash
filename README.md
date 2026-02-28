# Skeledirge: Auto-Spicetify Patcher (Linux Edition)

**Skeledirge** is a lightweight, pure Bash watchdog designed to keep your Linux Spotify client permanently patched with **Spicetify**. 

Linux package managers frequently update Spotify in the background, which completely overwrites Spicetify's UI modifications. Instead of manually reapplying your themes every time this happens, this script silently monitors the Spotify executable's metadata. It automatically triggers the Spicetify patch process *only* when an update is detected.

---

## 🚨 IMPORTANT: Know Your Spotify Version!

Before starting, you must know how Spotify was installed on your system. This script supports the two most common methods:
1. **System-wide (AUR / APT):** Installed via terminal commands like `yay -S spotify`, `pacman -S spotify`, or `apt install spotify`. The files live in `/opt/spotify` or `/usr/share/spotify`.
2. **User-level (Spotify-Launcher):** Installed via the `spotify-launcher` package. The files live hidden inside your personal Home folder (`~/.local/share/spotify-launcher/...`).

*(Note: Flatpak and Snap versions of Spotify are **not supported** because their sandboxed file systems block Spicetify and demand additional steps.)*

---

## 🚀 Step-by-Step Installation

### 1. Download the Script
Save `skeledirge.sh` to a permanent folder where you won't accidentally delete it (for example, create a folder named `Scripts` in your Home directory and put it there).

### 2. Make it Executable
Open your terminal, navigate to the folder where you saved the script, and grant it execution rights. 
*(Example: if you saved it in a folder called Scripts, type `cd ~/Scripts` then run:)*
```bash
chmod +x skeledirge.sh
```

### 3. Configure Spicetify Paths (CRITICAL STEP)
Spicetify needs to know exactly where to look. **Choose the option that matches your installation:**

**▶ OPTION A: If you use `spotify-launcher`**
You must manually point Spicetify to your hidden local folders. Run these commands in your terminal, **replacing `YOUR_USERNAME` with your actual Linux username**:
```bash
spicetify config spotify_path /home/YOUR_USERNAME/.local/share/spotify-launcher/install/usr/share/spotify
spicetify config prefs_path /home/YOUR_USERNAME/.config/spotify/prefs
```

**▶ OPTION B: If you use the AUR or APT (System-wide)**
Spicetify usually finds these automatically. However, because the files are owned by the system, you **must** grant your user permission to modify them. Run these commands once:
```bash
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
```

### 4. Run the Initial Setup
Run the script manually once to establish the baseline. This creates a hidden data folder (`~/.local/share/Skeledirge/`), saves the current Spotify signature, and applies your initial patch:
```bash
./skeledirge.sh
```

### 5. Automate on Startup
To make Skeledirge run invisibly every time you boot your PC, create an autostart entry:

1. Open your file manager, enable "Show Hidden Files", and navigate to `~/.config/autostart/`. (If the `autostart` folder doesn't exist, create it).
2. Inside that folder, create a new text file named `skeledirge.desktop`.
3. Open it in a text editor and paste the exact text below. 

**⚠️ WARNING:** You must change `/home/YOUR_USERNAME/Scripts/skeledirge.sh` to the exact, full path where you saved the script in Step 1. **Do not use the `~` symbol here!** It must be the absolute path.

```ini
[Desktop Entry]
Type=Application
Exec=/home/YOUR_USERNAME/Scripts/skeledirge.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Skeledirge
Comment=Spicetify Update Watchdog
```

Save the file. Skeledirge is now fully installed and will protect your themes on every reboot!

**Note**: If you encounter any error with the code or guide, please open a new tab on *Issues*.
