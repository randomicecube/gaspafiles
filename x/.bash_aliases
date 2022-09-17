alias ssh='TERM=xterm-256color /usr/bin/ssh'
alias clip='xclip -sel clip'

alias setenv-dsi='export JAVA_HOME="/usr/lib/jvm/java-8-openjdk" && export JAVA_OPTS="-server -Xms256m -Xmx1024m -XX:PermSize=384m" && export MAVEN_OPTS="$JAVA_OPTS -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false"'

alias vim="nvim"
alias neo="neofetch"

# list
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -la'
alias l='ls'
alias l.="ls -A | egrep '^\.'"

# git
alias gac="git add . && git commit -m"
alias gco="git checkout"
alias gm="git checkout master"
alias gp="git push"

# fix typos
alias cd..='cd ..'
alias maek="make"
alias pdw="pwd"
alias udpate='sudo pacman -Syyu'
alias upate='sudo pacman -Syyu'
alias updte='sudo pacman -Syyu'
alias updqte='sudo pacman -Syyu'
alias upqll="paru -Syu --noconfirm"
alias upal="paru -Syu --noconfirm"

# colorize grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# readable output for dh
alias df='df -h'

alias unlock="sudo rm /var/lib/pacman/db.lck"

alias rmpacmanlock="sudo rm /var/lib/pacman/db.lck"

alias rmlogoutlock="sudo rm /tmp/arcologout.lock"

alias whichvga="/usr/local/bin/arcolinux-which-vga"

alias free="free -mt"

alias wget="wget -c"

alias userlist="cut -d: -f1 /etc/passwd"

alias merge="xrdb -merge ~/.Xresources"

# Aliases for software managment

alias pacman='sudo pacman --color auto'

alias update='sudo pacman -Syyu'

alias pksyua="paru -Syu --noconfirm"

alias upall="paru -Syu --noconfirm"

alias psa="ps auxf"

alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias update-fc='sudo fc-cache -fv'

alias cb='sudo cp /etc/skel/.bashrc ~/.bashrc && source ~/.bashrc'

alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"

alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

alias tolightdm="sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"

alias tosddm="sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"

alias kc='killall conky'

alias hw="hwinfo --short"

alias paruskip='paru -S --mflags --skipinteg'

alias yayskip='yay -S --mflags --skipinteg'

alias trizenskip='trizen -S --skipinteg'

alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"

alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"

alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"

alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"

alias mirrorxx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"

alias ram='rate-arch-mirrors'

alias vbm="sudo /usr/local/bin/arcolinux-vbox-share"

alias yta-aac="youtube-dl --extract-audio --audio-format aac "

alias yta-best="youtube-dl --extract-audio --audio-format best "

alias yta-flac="youtube-dl --extract-audio --audio-format flac "

alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "

alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "

alias yta-opus="youtube-dl --extract-audio --audio-format opus "

alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "

alias yta-wav="youtube-dl --extract-audio --audio-format wav "

alias ytv-best="youtube-dl -f bestvideo+bestaudio "

alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

alias rg="rg --sort path"

alias jctl="journalctl -p 3 -xb"

alias nlightdm="sudo $EDITOR /etc/lightdm/lightdm.conf"

alias npacman="sudo $EDITOR /etc/pacman.conf"

alias ngrub="sudo $EDITOR /etc/default/grub"

alias nconfgrub="sudo $EDITOR /boot/grub/grub.cfg"

alias nmkinitcpio="sudo $EDITOR /etc/mkinitcpio.conf"

alias nmirrorlist="sudo $EDITOR /etc/pacman.d/mirrorlist"

alias narcomirrorlist='sudo nano /etc/pacman.d/arcolinux-mirrorlist'

alias nsddm="sudo $EDITOR /etc/sddm.conf"

alias nsddmk="sudo $EDITOR /etc/sddm.conf.d/kde_settings.conf"

alias nfstab="sudo $EDITOR /etc/fstab"

alias nnsswitch="sudo $EDITOR /etc/nsswitch.conf"

alias nsamba="sudo $EDITOR /etc/samba/smb.conf"

alias ngnupgconf="sudo nano /etc/pacman.d/gnupg/gpg.conf"

alias nb="$EDITOR ~/.bashrc"

alias nz="$EDITOR ~/.zshrc"

alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"

alias fix-gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"

alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

alias fix-gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

alias fix-keyserver="[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ ; echo 'done'"

alias fix-permissions="sudo chown -R $USER:$USER ~/.config ~/.local"

alias keyfix="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"

alias key-fix="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"

alias fixkey="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"

alias fix-key="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"

alias fix-sddm-config="/usr/local/bin/arcolinux-fix-sddm-config"

alias fix-pacman-conf="/usr/local/bin/arcolinux-fix-pacman-conf"

alias fix-pacman-keyserver="/usr/local/bin/arcolinux-fix-pacman-gpg-conf"

alias big="expac -H M '%m\t%n' | sort -h | nl"

alias downgrada="sudo downgrade --ala-url https://ant.seedhost.eu/arcolinux/"

alias probe="sudo -E hw-probe -all -upload"

alias sysfailed="systemctl list-units --failed"

alias ssn="sudo shutdown now"

alias sr="sudo reboot"

alias bls="betterlockscreen -u /usr/share/backgrounds/arcolinux/"

alias xd="ls /usr/share/xsessions"

alias att="arcolinux-tweak-tool"

alias adt="arcolinux-desktop-trasher"

alias abl="arcolinux-betterlockscreen"

alias agm="arcolinux-get-mirrors"

alias amr="arcolinux-mirrorlist-rank-info"

alias aom="arcolinux-osbeck-as-mirror"

alias ars="arcolinux-reflector-simple"

alias atm="arcolinux-tellme"

alias avs="arcolinux-vbox-share"

alias awa="arcolinux-welcome-app"

alias rmgitcache="rm -r ~/.cache/git"

alias personal='cp -Rf /personal/* ~'

alias at="alacritty-themes"
