# Comment at end of line is print toggle for print_aliases.sh

alias ls='ls --color=auto'
alias ccat='spc' #p~
alias yaourt-update='yaourt -Sbu --aur --noconfirm' #p~
alias aliases='~/scripts/print_aliases.sh' #p~
alias pacman='sudo pacman'
alias dammit='sudo bash -c "$(history -p !!)"' #p~
alias mannit='man "!!"'
alias ls='ls -l --color=auto'
alias grep='grep -E --color'
alias nmcli='nmcli -p'

man() {
	env LESS_TERMCAP_mb=$'\E[01;31m' \
		LESS_TERMCAP_md=$'\E[01;38;5;74m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_se=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[38;5;246m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
		man "$@"
}
