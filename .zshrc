# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### TOP ###
# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

export EDITOR='nvim'
export VISUAL='codium'
##################


### S4VITAR CONFIGS ###
# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
#####################


### ALIASES ###
#list#
alias ls='lsd --group-dirs=first'
alias la='lsd -A --group-dirs=first'
alias l='lsd --group-dirs=first'
alias l.="lsd -Al --group-dirs=first"

#Pacman#
alias sps='sudo pacman -S'
alias pcupdate='sudo pacman -Syyu'

#Colorized#
alias grep='grep --color=auto'

#Generals#
alias cat='bat'
alias tree='exa -T'
alias vim='nvim'
alias icat='kitty +kitten icat'
alias ff="fastfetch"
alias bspwman='bat -l bash /home/k1bas4r0/.config/sxhkd/sxhkdrc'
alias qcat='bat -l bash /home/k1bas4r0/.config/qtile/settings/keys.py'

#Common Fix#
alias cd..='cd ..'
alias pdw='pwd'
###################


### FUNCTIONS ###
#print comand Kitty
function kittman(){
    echo -e "\n[*]Super = Ctrl + Shift //"
    echo -e "\tFunctios:
        Open new window in this terminal         [Super + Intro]
        Close this window                        [Super + W]
        Move into windows                        [Super + Alt + Arrows]
        Rote ClockOrder this windows             [Super + B]

        Zoom in/out terminal                     [Super + Z]
        Resize this window                       [Super + R]

        Open new tab                             [Super + T]
        Change name tab                          [Super + Alt + T]
        Move into tabs                           [Super + Arrows]
        Move this tab left                       [Super + ,]
        Move this tab rigth                      [Super + .]

        Font zoom in                             [Super + Plus]
        Font zoom out                            [Super + Minus]

        Open new terminal                        [Super + N]"
}

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function rmk(){
    scrub -p dod $1
    shred -zun 10 -v $1
}
#########################

eval "$(zoxide init zsh)"


### BOT ###
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
###################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
