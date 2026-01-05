# Omarchy OS Automation Scripts



A collection of lightweight automation scripts designed for **Omarchy OS** (Arch Linux + Hyprland). These scripts run in the background to enhance productivity and system stability without user intervention.

---

## 🔓 Medium Link Unlocker
![Medium link automation image ](https://github.com/user-attachments/assets/98538402-ee10-479b-9efa-18f5a040f540)

**File:** `medium_unlocker.sh`

Automatically detects when you copy a Premium Medium link (`medium.com`), converts it to a free mirror (`freedium-mirror.cfd`), and opens it instantly in your browser.

### Features
- **Zero Click:** Just press `Ctrl+C` on a link
- **Resource Efficient:** Uses `wl-paste --watch` (0% CPU usage)
- **Smart Logic:** Only affects Medium links; ignores everything else

### Prerequisites
Ensure you have the Wayland clipboard tools installed:
```bash
sudo pacman -S wl-clipboard xdg-utils
```

### Installation
**1. Create the Script**

Create a file named `medium_unlocker.sh` inside your `~/Tools/` directory and paste the code from:
https://github.com/ujjawalTHEBATMAN/omarchy-os-Scripts-automation/blob/main/medium_unlocker.sh

**2. Make it Executable**
```bash
chmod +x ~/Tools/medium_unlocker.sh
```

---

## 📡 Smart Wifi Monitor
<img width="1024" height="559" alt="image" src="https://github.com/user-attachments/assets/ebc82a63-db58-48d6-adff-8afe8f83c537" />


**File:** `wifi_monitor.sh`

A background daemon that monitors your network connection. If the Wi-Fi drops, it automatically attempts to reconnect. It intelligently adjusts its check interval based on system activity to save resources.

### Features
- **Auto-Reconnect:** Detects downtime and restarts NetworkManager/connection
- **Adaptive Polling:** Checks less frequently when the system is idle
- **Lightweight:** Minimal system footprint

### Installation
**1. Create the Script**

Place your `wifi_monitor.sh` file inside your `~/Tools/` directory. Get the code from:
https://github.com/ujjawalTHEBATMAN/omarchy-os-Scripts-automation/blob/main/wifi_monitor.sh

**2. Make it Executable**
```bash
chmod +x ~/Tools/wifi_monitor.sh
```

---

## ⚙️ Auto-Start Configuration

To ensure both scripts run automatically in the background whenever you log in to Omarchy/Hyprland, add them to your startup config.

**1. Open your Hyprland Config:**
```bash
nvim ~/.config/hypr/hyprland.conf
```

**2. Add these lines to the end of the file:**
```bash
# --- Omarchy Automation Scripts ---
exec-once = /home/ujjawal/Tools/medium_unlocker.sh
exec-once = /home/ujjawal/Tools/wifi_monitor.sh
```

**3. Save and exit** (`:wq` in nvim)

---

## 🎮 Verification

**1. Restart Hyprland** (or log out and log back in)

**2. Check if scripts are running:**
```bash
pgrep -a bash
```

You should see both `medium_unlocker.sh` and `wifi_monitor.sh` in the output.

---

## 📝 Notes

- Replace `/home/ujjawal/Tools/` with your actual username and script location
- These scripts are designed for Wayland/Hyprland environments
- Both scripts run silently in the background with minimal resource usage

---

**Repository:** https://github.com/ujjawalTHEBATMAN/omarchy-os-Scripts-automation
