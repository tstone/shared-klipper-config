# shared-klipper-config

I created this repository primarily to share a standard set of Klipper configuration onto all my machines. Some of the code here I wrote, while some of it I found out on the internet. Anything I didn't write will have a header at the top with where it came from.

While these macros are setup in the way that I prefer, for my machines, you're welcome to use anything you find here if it's valuable to you. I've done my best to avoid having macros that assume things exist outside of what is captured in this repo. In some cases, to fully utilize a macro, additional variables will need to be set, or the macro will need to be plugged in to other machine macros.

-------

## Installation

#### 1. Download & Install
```
ssh you@machine
cd ~
git clone https://github.com/tstone/shared-klipper-config.git
cd shared-klipper-config
./install.sh
```

⚠️ Moonraker requires that the repo be cloned with HTTPS instead of SSH.

#### 2. Moonraker
Add the following to `moonraker.conf`:

```
[update_manager client shared-klipper-config]
type: git_repo
path: ~/shared-klipper-config
origin: https://github.com/tstone/shared-klipper-config.git
install_script: install.sh
managed_services: klipper
```

#### 3. Import
Add to `printer.cfg`:

```
# To use all macros uncomment
# [include nb.shared/macros/all.cfg]

# To use all menus uncomment
# [include nb.shared/menus/all.cfg]

# To use specific macros add the path as:
# [include nb.shared/macros/beep.cfg]
```

#### 4. Optional Macros

These macros will make use the following macros if they are defined:

  * `_READY_DISPLAY` - Display mode when the printer is ready for the next action
  * `_MESHING_DISPLAY` - Display mode when the printer is performing bed meshing
  * `_HEATING_DISPLAY` - Display mode when the printer is heating
  * `_COOLING_DISPLAY` - Display mode when the printer is cooling
  * `_LOADING_DISPLAY` - Display mode when the printer is loading filament
  * `_UNLOADING_DISPLAY` - Display mode when the printer is unloading filament