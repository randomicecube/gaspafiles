# 1920x1080 mode for the laptop screen
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode eDP-1 1920x1080_60.00
xrandr --output eDP-1 --mode 1920x1080_60.00

slstatus &
picom &
redshift &

# had to hardcode the feh section, god knows why
feh --bg-fill '/home/gaspa/Downloads/wall.jpg'
/home/gaspa/.screenlayout/arandr_1920x1080.sh
feh --bg-fill '/home/gaspa/Downloads/wall.jpg'

setxkbmap -layout pt
export GTK_THEME=Dracula
export EDITOR=nvim

exec dbus-launch dwm
