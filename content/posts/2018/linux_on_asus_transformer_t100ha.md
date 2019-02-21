---
title: "Linux on asus transformer T100HA"
date: 2018-09-26T07:33:48-05:00
tags: [linux asus ubuntu]
---

Problems found installing  **\*ubuntu 18.04/18.10** on an Asus Transformer T100HA

## ERROR (Xubuntu 18.04): ```GDBus.Error.org.freedesktop.login1 SleepVerbNotSupported```

### Solution: 

+ edit `/etc/modprobe.d/blacklist.conf` and add the following line:

    blacklist snd_hdmi_lpe_audio

* reboot

## ERROR (Lubuntu 18.04): Backlight not working

-  Check if `/sys/class/backlight` link file exists.
   If does not exist, create like in this tutorial: https://askubuntu.com/a/715310/578393.
   On Asus T110H: `/sys/class/backlight/intel_backlight -> ../../devices/pci0000:00/0000:00:02.0/drm/card0/card0-DSI-1/intel_backlight`

- Create the /etc/X11/xorg.conf file with:

```
    Section "Device"
    Identifier  "Intel Graphics"
    Driver      "intel"
    Option      "Backlight"  "intel_backlight"
    EndSection
```



