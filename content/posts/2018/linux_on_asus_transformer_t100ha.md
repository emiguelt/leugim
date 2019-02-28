---
title: "Linux on asus transformer T101H"
date: 2018-09-26T07:33:48-05:00
tags: [linux, asus, ubuntu]
---

Problems found installing  **\*ubuntu 18.04/18.10** on an Asus Transformer T101H

## ERROR (Xubuntu 18.04): ```GDBus.Error.org.freedesktop.login1 SleepVerbNotSupported```

### Solution: 

+ edit `/etc/modprobe.d/blacklist.conf` and add the following line:

    blacklist snd_hdmi_lpe_audio

* reboot

## ERROR (Lubuntu 18.04): Backlight not working

-  Check if `/sys/class/backlight` link file exists.
   If does not exist, create like in this tutorial: https://askubuntu.com/a/715310/578393.
   On Asus T101H: `/sys/class/backlight/intel_backlight -> ../../devices/pci0000:00/0000:00:02.0/drm/card0/card0-DSI-1/intel_backlight`

- Create the /etc/X11/xorg.conf file with:

```
    Section "Device"
    Identifier  "Intel Graphics"
    Driver      "intel"
    Option      "Backlight"  "intel_backlight"
    EndSection
```

- The backlight will work with ctrl+f10 and ctrl+f11 (Pending, change to fn+f5 and fn+f6 keys)

### Enable autorotation

* Identify the display ID: Execute `xrandr` and check the name, for Asus T101H is DSI1
* Identify the touchscren ID
  * Execute `xinput`
  * Identify all *slave pointer* devices
  * You can disable/enable de device and touch the display to test if is the correct device: `xinput disable <ID>`. To re-enable run `xinput enable <ID>`
  * Once you have identified the device, use the ID in the script
  * The Asus touchscreen name is: _SIS0457:00 0457:11ED_
* Copy following script and configure to start in the startup:

{{< gist emiguelt 9d37c796d8cfc820e03b3fcaa53da309 >}}

