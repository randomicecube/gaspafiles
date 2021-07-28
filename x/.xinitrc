# Double monitor layout
/home/gaspa/.screenlayout/arandr_1920x1080.sh

picom --experimental-backends & # flag is needed for blur to take effect
slstatus &
redshift &
dunst &

/home/gaspa/.local/bin/utils/setbg

setxkbmap -layout pt

exec dbus-launch dwm
