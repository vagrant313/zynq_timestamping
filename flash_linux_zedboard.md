1) Right now, your jumper MIO[4] and MIO[5] are set. You need to unset MIO[4] so that only MIO[5] is set. This will set your boot mode to QSPI instead of SD Card
2) Connect a USB cable to the JTAG port on the zedboard
3) Source Vivado or SDK on your computer
4) run "flash-jtag.py -b"
5) Wait for completion
6) Once done, reboot the zedboard and in u-boot, press any key whithin 3 sec to enter u-boot menu
7) Type "run update_payload"
8) Connect usb cable to OTG port (you can remove the JTAG usb cable)
9) run "flash-dfu.py -p"

10) wait for completion and then reboot

once this is done let me know and I'll show you how to run the software

To run the software timestamping.elf, you need to copy the libs inside lib2 and libadi to /usr/lib
