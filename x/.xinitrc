# 1920x1080 mode for the laptop screen
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode eDP-1 1920x1080_60.00
xrandr --output eDP-1 --mode 1920x1080_60.00

picom --experimental-backends & # flag is needed for blur to take effect
slstatus &
redshift &
dunst &

# had to hardcode the script itself for god knows what reason
/home/gaspa/.local/bin/utils/setbg
/home/gaspa/.screenlayout/arandr_1920x1080.sh
/home/gaspa/.local/bin/utils/setbg

setxkbmap -layout pt

exec dbus-launch dwm
