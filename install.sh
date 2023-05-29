#!/bin/bash
PRINTER_DATA_PATH="${HOME}/printer_data"
INSTALL_PATH="${PRINTER_DATA_PATH}/config/nb.shared"

# This installation script was inspired by and borrows from:
# https://github.com/protoloft/klipper_z_calibration/blob/master/install.sh


verify_ready()
{
  if [ "$EUID" -eq 0 ]; then
    echo "This script must not run as root"
    exit -1
  fi
}

setup_files()
{
  # macros
  mkdir -p "${INSTALL_PATH}"
  ln -sf "${SRC_DIR}/macros" "${INSTALL_PATH}"
  ln -sf "${SRC_DIR}/menus" "${INSTALL_PATH}"

  # If git is being used by this machine, add shared to the gitignore
  if [ -d "${PRINTER_DATA_PATH}/.git" ]; then
    touch "${PRINTER_DATA_PATH}/.gitignore"
    IGNORE_PRESENT=$(cat "${PRINTER_DATA_PATH}/.gitignore" | grep "config/nb.shared/" | wc -l)
    if [ $IGNORE_PRESENT -eq "0" ]; then
      echo "config/nb.shared/" >> "${PRINTER_DATA_PATH}/.gitignore"
    fi
  fi
}

restart_klipper()
{
  echo "Restarting Klipper..."
  sudo systemctl restart klipper
}

# Force script to exit if an error occurs
set -e

# Find SRCDIR from the pathname of this script
SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/ && pwd )"

# install
verify_ready
setup_files
restart_klipper
