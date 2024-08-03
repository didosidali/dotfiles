# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# ~/.zshrc
#
HISTFILE=~/.zsh_history

HISTFILESIZE=1000000000
HISTSIZE=1000000000
SAVEHIST=1000000000
bindkey -v
bindkey '^R' history-incremental-search-backward

setopt SHARE_HISTORY

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
autoload -Uz compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt walters

alias ls='lsd --color=auto'
PROMPT="%F{red}%n%f%F{blue}@%f%F{green}%m%f %~ $ "
RPROMPT=""

alias vim="nvim"
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

alias app-det="sh /home/sid/scripts/projects/application-classification.sh"
alias phd-manu="sh /home/sid/scripts/projects/phd-manuscript.sh"

export ZSH="$HOME/.oh-my-zsh/" 

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source "$HOME/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
# source "/home/sid/.oh-my-zsh/custom/themes/agnoster-zsh-theme/agnoster.zsh-theme"

ZSH_THEME="powerlevel10k/powerlevel10k"

if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
  [[ ! -f ~/.config/p10k/p10k.zsh ]] || source ~/.config/p10k/p10k.zsh
else
  [[ ! -f ~/.config/p10k/p10k.zsh ]] || source ~/.config/p10k/p10k_8.zsh
fi


# ZSH_THEME="agnoster-zsh-theme/agnoster.zsh-theme"
