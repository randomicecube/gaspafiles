xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode eDP-1 1600x900_60.00
xrandr --output eDP-1 --mode 1600x900_60.00
slstatus &
picom &
redshift &
setxkbmap -layout pt
export GTK_THEME=Dracula
export EDITOR=nvim
feh --bg-fill ~/Downloads/lofi-cafe.jpg
/home/gaspa/.screenlayout/arandr_1600x900.sh
feh --bg-fill ~/Downloads/lofi-cafe.jpg
setxkbmap -layout pt
exec dbus-launch dwm
