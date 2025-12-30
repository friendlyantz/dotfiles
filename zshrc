# CI shortcuts to see WebUI
export WORK_ORG=marketplacer
buildkite () {
  open "https://buildkite.com/${WORK_ORG}/$(basename $PWD)"
}
semaphore () {
  open "https://${WORK_ORG}.semaphoreci.com/projects/$(basename $PWD)"
}

ghdiff () {
  local branch="${1:-$(git branch --show-current)}"
  open "https://github.com/${WORK_ORG}/$(basename $PWD)/compare/main...${branch}"
}

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
ZSH_DISABLE_COMPFIX="true" # for bypassing RT warnings

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search mise)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load rbenv if installed (To manage your Ruby versions)
export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Load pyenv (To manage your Python versions)
export PATH="${HOME}/.pyenv/bin:${PATH}" # Needed for Linux/WSL
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"

# Load nvm if installed (To manage your Node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GPG_TTY=$TTY

# GitHub token for API access (used by mise, etc.)
export GITHUB_TOKEN=$(gh auth token 2>/dev/null || echo "")

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export BUNDLER_EDITOR=nvim
export EDITOR=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias pgstart='pg_ctl -D tmp/postgres -l tmp/postgres/logfile start || echo "pg was probably running"'
alias pgstop='pg_ctl -D tmp/postgres -l tmp/postgres/logfile stop || echo "pg was probably stopped"'
alias msfconsole='/opt/metasploit-framework/bin/msfconsole'

export PATH="$HOME/.bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/homebrew/opt/kubernetes-cli@1.22/bin:$PATH"
set -o vi

export BUNDLER_EDITOR="code $@"


# initialise completions with ZSHs compinit
autoload -Uz compinit && compinit

# mise activation needs to be after compinit
eval "$(~/.local/bin/mise activate zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

export BETTER_ERRORS_EDITOR="code --wait"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# jj vsc autocompletion
autoload -U compinit
compinit
source <(jj util completion zsh)


export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"
# export PATH="/Applications/RubyMine.app/Contents/MacOS:$PATH"

eval "$(atuin init zsh)"

DISABLE_AUTO_TITLE="true" # To allow tmux to show the name of tabs in zsh for iTerm2export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var currentDirectory $(basename $(pwd))
}

# Load local environment variables (untracked)
[[ -f "$HOME/code/dotfiles/.env.local" ]] && source "$HOME/code/dotfiles/.env.local"

export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

