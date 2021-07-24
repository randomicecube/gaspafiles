setxkbmap -layout pt

xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode eDP-1 1600x900_60.00
xrandr --output eDP-1 --mode 1600x900_60.00

slstatus &
picom &
redshift &
# for some reason i've got to execute fehbg twice, before and after arandr
~/.fehbg &
/home/gaspa/.screenlayout/arandr_1600x900.sh
~/.fehbg &

export GTK_THEME=Dracula
export EDITOR=nvim

exec dbus-launch dwm
