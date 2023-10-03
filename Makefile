.DEFAULT_GOAL := usage

# user and repo
USER        = $$(whoami)
CURRENT_DIR = $(notdir $(shell pwd))

# terminal colours
RED     = \033[0;31m
GREEN   = \033[0;32m
YELLOW  = \033[0;33m
NC      = \033[0m
# versions
APP_REVISION    = $(shell git rev-parse HEAD)

.PHONY: brew-install
brew-install:
	xcode-select --install
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: brew-essentials
brew-essentials:
	brew upgrade git || brew install git
	brew upgrade gh || brew install gh
	brew upgrade wget || brew install wget
	brew upgrade imagemagick || brew install imagemagick
	brew upgrade jq || brew install jq
	brew upgrade openssl || brew install openssl

.PHONY: brew-extra
brew-extra:
	brew upgrade bat || brew install bat
	brew upgrade gpg-suite-no-mail ||brew install --cask gpg-suite-no-mail
	brew upgrade git-delta ||brew install git-delta
	brew upgrade asdf ||brew install asdf

.PHONY: brew-neovim
brew-neovim:
	brew install neovim

.PHONY: brew-vscode
brew-vscode:
	brew install --cask visual-studio-code
	@echo
	@echo "run ${YELLOW}code${NC} to check if VS code was installed correctly"

.PHONY: brew-zoom
brew-zoom:
	brew install --cask zoom

.PHONY: brew-iterm
brew-iterm:
	brew install --cask iterm2

.PHONY: zsh
zsh:
	@sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

.PHONY: gh-cli
gh-cli:
	gh auth login -s 'user:email' -w
	gh auth status
	gh api user/emails | jq -r '.[].email'

.PHONY: dotfiles
dotfiles:
	cd ~/code/$GITHUB_USERNAME/dotfiles
	gh repo clone friendlyantz/dotfiles

.PHONY: dotfiles-install
dotfiles-install:
	zsh install.sh

.PHONY: dotfiles-git
dotfiles-git:
	gpg --full-generate-key
	gpg --list-secret-keys --keyid-format=long
	zsh git_setup.sh

.PHONY: zsh-powershell10k
zsh-powershell10k:
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

.PHONY: asdf-ruby
asdf-ruby:
	asdf plugin add ruby
	asdf install ruby latest
	asdf global ruby latest

.PHONY: gem-essentials
gem-essentials:
	gem install colorize faker http pry-byebug rake rails rest-client rspec rubocop-performance sqlite3

.PHONY: readmore
readmore:
	open https://github.com/lewagon/setup/blob/master/macos.md#macos-settings


.PHONY: usage
usage:
	@echo
	@echo "Hi ${GREEN}${USER}!${NC} Welcome to ${RED}${CURRENT_DIR}${NC}"
	@echo
	@echo "${RED}First things first:${NC}"
	@echo "	Browsers Install: FF, Brave, Chrome, etc"
	@echo "	AppStore: Magnet, VPN, etc"
	@echo "	VPN, Pass Manager"
	@echo "Getting started as per https://github.com/lewagon/setup/blob/master/macos.md"
	@echo
	@echo "${YELLOW}make brew-install${NC}             install brew and xcode"
	@echo "${YELLOW}make brew-essentials${NC}          brew essential apps"
	@echo "${YELLOW}make brew-extra${NC}               brew asdf, git-delta, batcat"
	@echo "${YELLOW}make brew-iterm${NC}               brew iTerm2"
	@echo "${YELLOW}make brew-neovim${NC}              brew neovim"
	@echo "${YELLOW}make brew-vscode${NC}              brew vscode"
	@echo "${YELLOW}make brew-zoom${NC}                brew zoom"
	@echo
	@echo "${YELLOW}make zsh${NC}                      install ZSH"
	@echo
	@echo "${YELLOW}make gh-cli${NC}                   login GitHub CLI"
	@echo
	@echo "${YELLOW}make dotfiles${NC}                 IF HAVENT done already, pull dotfiles"
	@echo "${YELLOW}make dotfiles-install${NC}         zsh install.sh"
	@echo "${YELLOW}make zsh-powershell10k${NC}        zsh-powershell10k(ensure to use UNICODE) OR to retry: 'p10k configure'"
	@echo
	@echo "${YELLOW}make asdf-ruby${NC}                install Ruby via asdf"
	@echo "${YELLOW}make gem-essentials${NC}           install Ruby essential gems"
	@echo
	@echo "${YELLOW}make readmore${NC}                 further options tweaks and scripts"
	@echo

