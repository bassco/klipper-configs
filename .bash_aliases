export EDITOR=vim VISUAL=vim
export GPG_TTY=$(tty)
export LC_ALL="$LANG"
export LANGUAGE="$LANG"
alias gco='git checkout'
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias vip='vim ~/klipper_config/printer.cfg'
alias vipm='vim ~/klipper_config/printer_macros.cfg'
alias vik='vim ~/klipper_config/'
function printer(){
 . ~/klipper_config/klipper.config
 cd ~/dev/klipper-configs/$PRINTER
}
. ~/.bash_aliases_extras 2>/dev/null
alias temp="/usr/bin/vcgencmd measure_temp"
