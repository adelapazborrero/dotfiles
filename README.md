# dotfiles

For remaping keys in gnome
```
sudo apt update && sudo apt install input-remapper
```

Personal files for easy pulling

[Extensions]
- caffeine@patapon.info
- focus-changer@heartmire
- blur-my-shell@aunetx
- logomenu@aryan_k
- ubuntu-appindicators@ubuntu.com
- dash-to-dock@micxgx.gmail.com
- ding@rastersoft.com
- tiling-assistant@leleat-on-github
- apps-menu@gnome-shell-extensions.gcampax.github.com
- auto-move-windows@gnome-shell-extensions.gcampax.github.com
- drive-menu@gnome-shell-extensions.gcampax.github.com
- launch-new-instance@gnome-shell-extensions.gcampax.github.com
- native-window-placement@gnome-shell-extensions.gcampax.github.com
- places-menu@gnome-shell-extensions.gcampax.github.com
- screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
- user-theme@gnome-shell-extensions.gcampax.github.com
- window-list@gnome-shell-extensions.gcampax.github.com
- windowsNavigator@gnome-shell-extensions.gcampax.github.com
- workspace-indicator@gnome-shell-extensions.gcampax.github.com
- tun0-ip-address@adamantisspinae.github.com
- showmethetext@Guleri24.github.com

### Mate desktop setup
- Icons [https://www.wallpapertip.com/wpic/bJmxhh_mr-robot-elliot-pc/](https://www.mate-look.org/p/1012151)
- Wallpaper https://www.wallpapertip.com/wpic/bJmxhh_mr-robot-elliot-pc/
- Theme https://www.mate-look.org/p/1013477
- Window borders https://github.com/adelapazborrero/DarkRobot

```
sudo apt install mate-desktop-environment
sudo apt install mate-desktop-environment-extras
sudo apt install lightdm lightdm-gtk-greeter
sudo apt-get install lightdm-gtk-greeter-settings

sudo update-alternatives --config x-session-manager

sudo apt purge --autoremove kali-desktop-xfce

cp icons /usr/share/icons/
cp theme /usr/share/themes/
cp background /usr/share/desktop-base/kali-theme/login/background

sudo apt-get -y install aptitude
sudo aptitude -y install mate-tweak
```

### Firefox setup
1. Type `about:config`
2. Enable `toolkit.legacyUserProfileCustomizations.stylesheets`
3. Type `about:support`
4. Go to your `Profile Directory`
5. Add `https://github.com/Aris-t2/CustomCSSforFx/tree/master/current` to `chrome` (create folder if not exists)
6. Restart firefox

### Linux battery life
Other new tools https://github.com/AdnanHodzic/auto-cpufreq?tab=readme-ov-file#installing-auto-cpufreq

Update packages
```
sudo apt update
```

Install tlp
```
sudo apt install tlp tlp-rdw
```

Enable daemon
```
sudo systemctl enable tlp.service
```

Checking battery health
```
upower -e
upower -i /org/freedesktop/UPower/devices/battery_BAT1
```
Have a look at `energy-full` and `energy-full-design`, if change is significant is time to update.

```
acpi -V
```
Loot at `Thermal`, `desicn capacity` and `last full capacity`


### For mate destop small resolution
```
xrandr --output DP-2 --mode 3840x2160 --scale 1x1
gsettings set org.mate.interface window-scaling-factor 1
gsettings set org.mate.font-rendering dpi 128
echo "For firefox open about:config, set layout.css.devPixelsPerPx to 1.4"
```

### VMware on kali

Download vmware workstation
[https://www.vmware.com/uk/products/workstation-player.html](https://support.broadcom.com/group/ecx/productfiles?subFamily=VMware%20Workstation%20Pro&displayGroup=VMware%20Workstation%20Pro%2017.0%20for%20Personal%20Use%20(Linux)&release=17.5.2&os=&servicePk=520450&language=EN)

Add missing packages
```
sudo apt install -y build-essential linux-headers-$( uname -r ) vlan libaio1
```
For missing vmnet modules follow these lines from kernel
```bash
sudo nvim /usr/src/linux-headers-6.8.11-amd64/scripts/Makefile.modfinal
-ifdef CONFIG_DEBUG_INFO_BTF_MODULES
-        +$(if $(newer-prereqs),$(call cmd,btf_ko))
-endif
```

Activation for VM
```
https://github.com/massgravel/Microsoft-Activation-Scripts
```

### RGB linux
https://alternativeto.net/software/openrgb/about/

### Windows GCC
https://sourceforge.net/projects/tdm-gcc/
Add `C:\TDM-GCC-64\bin` to the `PATH` Environment variable

### Windows Installation scripts

https://github.com/elitekamrul/MAS
```powershell
irm https://elite.kamrul.us/get | iex
# or
irm https://massgrave.dev/get | iex
```
