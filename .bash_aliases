export EDITOR=vim VISUAL=vim SYSTEM_EDITOR=vim
export GPG_TTY=$(tty)
export LC_ALL="$LANG"
export LANGUAGE="$LANG"
alias gco='git checkout'
alias gs='git status'
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
alias l='ls -la ${@}'
alias ll='ls -la ${@}'

# wget https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-armv7-unknown-linux-musleabi.tar.gz -O /tmp/rg.tgz && tar xzf /tmp/rg.tgz && sudo mv /tmp/rg /usr/local/bin/
# wget https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-musl_10.3.0_armhf.deb -O /tmp/fd.deb && sudo apt install -y ./tmp/fd.deb 
eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
