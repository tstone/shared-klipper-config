#!/bin/bash
set -e

# Run as:
# KCONFIG_CONFIG=name ./update_can_bridge_mcu.sh ca5b098aba5b usb-katapult_stm32f429xx_2E0022001651323039323733-if00

# References:
# https://github.com/Esoterical/voron_canbus/blob/main/mainboard_flashing/README.md
# https://github.com/muyouhcd/klipper/blob/master/docs/gcode_shell_command.md

CAN_UUID=$1
SERIAL=$2

# build new firmware
cd ~/klipper
make clean
make KCONFIG_CONFIG=$KCONFIG_CONFIG

# stop Klipper
sudo service klipper stop
# Put MCU in boot mode
python3 ~/katapult/scripts/flashtool.py -i can0 -u $CAN_UUID -r
sleep 2
# Flash MCU with new firmware
python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/$SERIAL
# restart klipper
sudo service klipper start