---
title: "Linux on asus transformer t100ha"
date: 2018-09-26T07:33:48-05:00
tags: [linux]
---

Problems found installing  **Xubuntu 18.04** on an Asus Transformer T100ha

## ERROR: ```GDBus.Error.org.freedesktop.login1 SleepVerbNotSupported```

### Solution: 

+ edit ```/etc/modprobe.d/blacklist.conf```and add the following line:

    blacklist snd_hdmi_lpe_audio

* reboot

