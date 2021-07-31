if status is-interactive
	uwufetch
	export GTK_THEME=Dracula
	export EDITOR=nvim
	export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:.local/bin
  alias compile="gcc -ansi -pedantic -Wall -Wextra -Werror"
  alias vim="nvim"
	alias uwu="uwufetch"
	alias neo="neofetch"
  alias gac="git add . && git commit -m"
  alias gm="git checkout master"
  alias gp="git push"
end
