# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
ZSH_DISABLE_COMPFIX="true" # for bypassing RT warnings

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search)

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

# Load 'lewagon' virtualenv for the Data Bootcamp. You can comment these 2 lines to disable this behavior.
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# pyenv activate lewagon 2>/dev/null && echo "🐍 Loading 'lewagon' virtualenv"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GPG_TTY=$TTY

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export BUNDLER_EDITOR=code
export EDITOR=vi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias pgstart='pg_ctl -D tmp/postgres -l tmp/postgres/logfile start || echo "pg was probably running"'
alias pgstop='pg_ctl -D tmp/postgres -l tmp/postgres/logfile stop || echo "pg was probably stopped"'
alias msfconsole='/opt/metasploit-framework/bin/msfconsole'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/homebrew/opt/kubernetes-cli@1.22/bin:$PATH"
set -o vi

export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"

. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

export BETTER_ERRORS_EDITOR="code --wait"
