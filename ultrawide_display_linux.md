# Ultrawide Monitor Setup - 3440x1440 Resolution

## Problem
ThinkPad T480 with external ultrawide 2K monitor (3440x1440) was only displaying at 2560x1080 when connected via HDMI. The HDMI cable couldn't support the full bandwidth needed for native resolution.

## Solution
Use USB-C to HDMI adapter for full bandwidth support, then manually add the 3440x1440 resolution mode.

## Hardware
- **Laptop**: ThinkPad T480 (1920x1080 internal display)
- **Monitor**: Ultrawide 2K (3440x1440 native resolution)
- **Connection**: USB-C to HDMI adapter (supports full 2K bandwidth)

---

## Commands to Set 3440x1440 Resolution

### 1. Check Current Display Configuration
```bash
xrandr --query
```
Look for your external monitor (likely DP-1 or HDMI-1/2)

### 2. Generate Modeline for 3440x1440
```bash
cvt 3440 1440 60
```

Output example:
```
# 3440x1440 59.94 Hz (CVT) hsync: 89.48 kHz; pclk: 419.50 MHz
Modeline "3440x1440_60.00"  419.50  3440 3696 4064 4688  1440 1443 1453 1493 -hsync +vsync
```

### 3. Add the New Resolution Mode
```bash
xrandr --newmode "3440x1440_60.00" 419.50 3440 3696 4064 4688 1440 1443 1453 1493 -hsync +vsync
```

### 4. Add Mode to Your Monitor
Replace `DP-1` with your actual monitor name (check step 1):
```bash
xrandr --addmode DP-1 3440x1440_60.00
```

### 5. Apply the Resolution
```bash
xrandr --output DP-1 --mode 3440x1440_60.00
```

### 6. Verify It Worked
```bash
xrandr | grep "DP-1" -A 1
```

You should see: `DP-1 connected 3440x1440+...`

---

## Making It Permanent

The resolution change needs to be applied each time you connect the monitor. This is handled automatically by the script at:

**Location**: `~/.config/autostart-scripts/setup-ultrawide.sh`

The script runs automatically at login when the monitor is connected.

### Manual Script Execution
If needed, you can manually run:
```bash
~/.config/autostart-scripts/setup-ultrawide.sh
```

---

## Troubleshooting

### Monitor Shows as Different Port
If your monitor shows as HDMI-1, HDMI-2, or DP-2 instead of DP-1, update the script:
1. Edit: `~/.config/autostart-scripts/setup-ultrawide.sh`
2. Change `DP-1` to your actual monitor port name
3. Save and restart

### Resolution Not Available
- Ensure you're using USB-C connection (HDMI doesn't support full bandwidth)
- Check cable quality - use a certified high-speed cable
- Try a different USB-C port on your laptop

### Blurry Display
- Don't use `xrandr --scale` - it causes software scaling
- Ensure you're at native 3440x1440 resolution
- Check monitor OSD settings for sharpness

### Per-Monitor Scaling (if UI elements too large/small)
```bash
# Enable fractional scaling
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

# Then adjust in Display Settings GUI
gnome-control-center display
```

---

## Quick Reference

**Check displays**: `xrandr --query`
**Apply resolution**: `xrandr --output DP-1 --mode 3440x1440_60.00`
**Reset display**: `xrandr --output DP-1 --auto`
**Open display settings**: `gnome-control-center display`

