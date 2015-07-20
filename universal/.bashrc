#
# ~/.bashrc
#

  # ANSI color codes
RS="\033[0m"    # reset
HC="\033[1m"    # hicolor
UL="\033[4m"    # underline
INV="\033[7m"   # inverse background and foreground
FBLK="\033[30m" # foreground black
FRED="\033[31m" # foreground red
FGRN="\033[32m" # foreground green
FYEL="\033[33m" # foreground yellow
FBLE="\033[34m" # foreground blue
FMAG="\033[35m" # foreground magenta
FCYN="\033[36m" # foreground cyan
FWHT="\033[37m" # foreground white
BBLK="\033[40m" # background black
BRED="\033[41m" # background red
BGRN="\033[42m" # background green
BYEL="\033[43m" # background yellow
BBLE="\033[44m" # background blue
BMAG="\033[45m" # background magenta
BCYN="\033[46m" # background cyan
BWHT="\033[47m" # background white


# Every machine
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.keychain/$HOSTNAME-sh ]; then # Fix gpg issue regardless of host
	. ~/.keychain/$HOSTNAME-sh
fi

alias ls='ls -l --color=auto'
alias grep='grep -E --color'

if which vim &>/dev/null; then
	export EDITOR=vim
	export VISUAL=vim
else
	export EDITOR=vi
	export VISUAL=vi
fi

auto_ssh_key() {
	for key in $(command ls -1 ~/.ssh | grep -E 'rsa[^\.]*$'); do
		keychain -q --nogui ~/.ssh/$key
	done
}

# Machine-specific
WORKSTATIONS="aqua blue cyan diamond emerald honey neon orange pink silver taupe violet xray yellow"
if [[ $WORKSTATIONS =~ $(hostname) ]]; then
	#OSL Host stuff
	export HISTFILESIZE=10000000000
	export HISTTIMEFORMAT="%F %T "
	
	auto_ssh_key
	
	function fsh () {
		ssh -t -i ~/.ssh/id_rsa-fir fir "sudo bash -i -c \"ssh $@\""
	}
	
	alias ldapvi='ldapvi -D uid=tolvstaa,ou=People,dc=osuosl,dc=org -h ldaps://ldap1.osuosl.org'
	alias gfr='git fetch && git rebase remotes/origin/master'
	alias ff='ssh -t fir sudo vim /root/.../firfile'
	alias vpn='sudo openvpn ~/.openvpn/openvpn.conf'
	alias mr="mr -j 8 $@"
elif [[ $(hostname) = "avalon-arch" ]]; then
	#Avalon stuff
	if [ -z $(pidof gpg-agent) ]; then
		auto_ssh_key
	fi
else
	if which keychain &>/dev/null; then
		auto_ssh_key
	fi
fi

_git_ps1() {
	local mygit="$(git symbolic-ref --short HEAD 2>/dev/null)";
	if [ "$(echo "$mygit" | wc -m)" -gt $1 ]; then
		mygit="…$(echo $mygit | tail -c $1)"
	fi
	echo -e $mygit
}

_pwd_ps1() {
	local newPWD=""
	local fracLim=4

	if [ "$HOME" == "$PWD" ]; then
		newPWD="~"
	elif [ "$HOME" == "${PWD:0:${#HOME}}" ]; then
		newPWD="~${PWD:${#HOME}}"
	else
		newPWD=$PWD
	fi

	local fields=$(echo $newPWD | awk 'BEGIN{FS="/"};{print NF}')
	
	while [ "${#newPWD}" -gt "$(( COLUMNS / fracLim ))" ] && [ "$fields" -gt "0" ]; do
		newPWD=$( echo $newPWD | cut -d"/" -f 2- )
		fields=$((fields - 1))
	done
	echo $newPWD
}

prompt_command() {
	if [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
		if [ -n "$COLUMNS" ] && [ "$COLUMNS" -lt 120 ]; then # short git
			PS1="[\[${FCYN}\]\u@\h\[${RS}\]|\[${FGRN}\]\W\[${RS}\]|\[${FYEL}\]\$(_git_ps1 8)\[${RS}\]]\$ "
		else
			PS1="(\A)\[${FCYN}\]\u@\h\[${RS}\]:\[${FGRN}\]\$(_pwd_ps1)\[${RS}\][\[${FYEL}\]\$(_git_ps1 16)\[${RS}\]]\$ "
		fi
	else
		if [ -n "$COLUMNS" ] && [ "$COLUMNS" -lt 120 ]; then # short
			PS1="[\[${FCYN}\]\u@\h\[${RS}\]|\[${FGRN}\]\W\[${RS}\]]\$ "
		else
			PS1="(\A)\[${FCYN}\]\u@\h\[${RS}\]:\[${FGRN}\]\$(_pwd_ps1)\[${RS}\]\$ "
		fi
	fi
}

PROMPT_COMMAND=prompt_command
