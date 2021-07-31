# Double monitor layout
/home/gaspa/.screenlayout/arandr_1920x1080.sh

picom --experimental-backends & # flag is needed for blur to take effect
slstatus &
redshift &
dunst &
flameshot &

# currently not using it, although it's a nice script
# /home/gaspa/.local/bin/utils/setbg

/home/gaspa/.fehbg

setxkbmap -layout pt

# if dwm exits 0, restart -- this allows hot reloading of config.h
while type dwm >/dev/null ; do dwm && continue || break ; done
#
# exec dbus-launch dwm
#
# exec dwm
