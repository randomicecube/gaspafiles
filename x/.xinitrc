# Double monitor layout
/home/gaspa/.screenlayout/arandr_1920x1080.sh

setxkbmap pt
redshift &
flameshot &

export _JAVA_AWT_WM_NONREPARENTING=1

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
