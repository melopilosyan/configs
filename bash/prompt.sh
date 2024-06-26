# vi:ft=sh:

# xterm 256 color chart
# Run this to see them all
#  color=16; while [ $color -lt 245 ]; do echo -e "$color: \\033[38;5;${color}mhello\\033[48;5;${color}mworld\\033[0m"; ((color++)); done
#
# The ANSI sequence to select these, using the number in the bottom left corner,
# starts 38;5; for the foreground and 48;5; for the background, then the color
# number, so e.g.:
#
# echo -e "\\033[48;5;95;38;5;214mhello world\\033[0m"
#
# More c_info:
# https://phoenixnap.com/kb/change-bash-prompt-linux
# https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt

# if [[ "$TERM" =~ 256color ]]; then
#   PS1='\[\e[38;5;244m\]\t\[\e[0m\] \[\e[38;5;29m\]\W\[\e[0m\] \[\e[38;5;208m\]>\[\e[0m\]\[\e[38;5;196m\]>\[\e[0m\]\[\e[38;5;33m\]>\[\e[0m\] '
# fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_DESCRIBE_STYLE="branch"
export GIT_PS1_SHOWUPSTREAM="verbose name"

export c_inactive="\[\e[38;5;237m\]"
export c_info="\[\e[38;5;242m\]"
export c_green="\[\e[38;5;22m\]"
export c_ruby="\[\e[38;5;124m\]"
export c_git="\[\e[38;5;128m\]"
export c_cwd="\[\e[38;5;29m\]"
export c_err_code="\[\e[01;38;5;196m\]"
export c_separator="\[\e[38;5;26m\]"
export c_clear="\[\e[0m\]"

export primary_prompt_separator="󰞷 "
export secondary_prompt_separator=" "

user="$c_inactive  $c_info\u"
datetime="$c_inactive  $c_info\D{%d.%m %T}"
cwd="$c_cwd 󰝰 \W"
ruby_icon="$c_ruby  "

ltc="$c_green╭──"  # left top corner
lbc="$c_green╰─"   # left bottom corner

function __build_prompt_beginning() {
  local beginning error_code=$?

  if [[ $error_code != 0 ]]; then
    beginning="$c_info ╰─ $c_err_code$error_code\n"
  fi

  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    beginning="$beginning$ltc"
  fi

  echo -e "$beginning$c_clear"
}

system_info='"$(__build_prompt_beginning)$user$datetime$cwd$ruby_icon${RUBY_VERSION#*-}"'
git_info='"$c_git  (%s$c_git)\n$lbc"'
last_bit='"$c_separator $primary_prompt_separator$c_clear"'

PROMPT_COMMAND="__git_ps1 $system_info $last_bit $git_info"

PS2="$c_separator$secondary_prompt_separator$c_clear"
