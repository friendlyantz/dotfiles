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

.PHONY: xcode
xcode:
	xcode-select --install
	sudo xcode-select -switch /Library/Developer/CommandLineTools

.PHONY: brew-install
brew-install:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: brew-essentials
brew-essentials:
	brew upgrade git || brew install git
	brew upgrade gh || brew install gh
	gh extension install github/gh-copilot
	brew upgrade wget || brew install wget
	brew upgrade imagemagick || brew install imagemagick
	brew upgrade jq || brew install jq
	brew upgrade openssl || brew install openssl

.PHONY: brew-extra
brew-extra:
	brew upgrade bat || brew install bat
	brew upgrade tlrc || brew install tlrc
	brew upgrade gpg-suite-no-mail || brew install --cask gpg-suite-no-mail
	brew upgrade git-delta || brew install git-delta
	brew upgrade ripgrep || brew install ripgrep
	brew upgrade htop || brew install htop
	brew upgrade the_silver_searcher || brew install the_silver_searcher
	brew upgrade openssh || brew install openssh
	brew install nmap
	brew install exercism
	brew install --cask veracrypt

.PHONY: brew-imgcat
brew-imgcat:
	brew update eddieantonio/eddieantonio/imgcat || brew install eddieantonio/eddieantonio/imgcat

.PHONY: brew-browsers
brew-browsers:
	brew install --cask firefox
	brew install --cask google-chrome
	brew install --cask brave-browser
	brew install --cask tor-browser

.PHONY: brew-iterm
brew-iterm:
	brew install --cask iterm2

.PHONY: brew-fzf
brew-fzf:
	brew upgrade fzf || brew install fzf
	# To install useful key bindings and fuzzy completion:
	$(brew --prefix)/opt/fzf/install

.PHONY: brew-neovim
brew-neovim:
	brew install neovim

.PHONY: brew-vscode
brew-vscode:
	brew install --cask visual-studio-code
	@echo
	@echo "run ${YELLOW}code${NC} to check if VS code was installed correctly"

.PHONY: brew-discord
brew-discord:
	brew install --cask discord

.PHONY: brew-tuple
brew-tuple:
	brew install --cask tuple

.PHONY: brew-zoom
brew-zoom:
	brew install --cask zoom

.PHONY: brew-messengers
brew-messengers:
	brew install --cask slack
	brew install --cask signal
	brew install --cask telegram

.PHONY: brew-clouddrives
brew-clouddrives:
	brew install --cask nextcloud
	brew install --cask kdrive

.PHONY: brew-obsidian
brew-obsidian:
	brew install --cask obsidian

.PHONY: brew-spotify
brew-spotify:
	brew install --cask spotify

.PHONY: brew-prusaslicer
brew-prusaslicer:
	brew install --cask prusaslicer

.PHONY: brew-betaflight
brew-betaflight:
	brew install --cask betaflight-configurator

.PHONY: brew-apps
brew-apps: brew-discord brew-tuple brew-zoom brew-messengers brew-clouddrives brew-obsidian brew-spotify brew-prusaslicer brew-betaflight

.PHONY: zsh
zsh:
	@sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

.PHONY: zsh-syntax-highlighting
zsh-syntax-highlighting:
	@git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

.PHONY: zsh-powershell10k
zsh-powershell10k:
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

.PHONY: gh-cli
gh-cli:
	gh auth login -s 'user:email' -w
	gh auth status
	gh api user/emails | jq -r '.[].email'

.PHONY: dotfiles-install
dotfiles-install:
	zsh install.sh

.PHONY: gpg-gen
gpg-gen:
	gpg --full-generate-key --expert

.PHONY: gpg-list
gpg-list:
	gpg --list-secret-keys --keyid-format=long

.PHONY: dotfiles-git
dotfiles-git:
	zsh git_setup.sh

.PHONY: asdf-install
asdf-install:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1 || echo "asdf already installed"
	source ~/.asdf/asdf.sh
	asdf update

.PHONY: asdf-ruby
asdf-ruby:
	asdf plugin add ruby
	asdf install ruby latest
	asdf global ruby latest

.PHONY: ruby-gem-essentials
ruby-gem-essentials:
	gem install colorize faker http pry-byebug rake rails rest-client rspec rubocop-performance sqlite3 bundler

.PHONY: readmore
readmore:
	open https://github.com/lewagon/setup/blob/master/macos.md#macos-settings

.PHONY: mac-settings
mac-settings:
	# Save screenshots to the Desktop (or elsewhere)
	defaults write com.apple.screencapture location "${HOME}/Desktop"
	# Expanding the save panel by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
	# Set sidebar icon size to medium
	defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
	# Set highlight color to green
	defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"
	# Always show scrollbars
	defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
	# Save to disk (not to iCloud) by default
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
	# Disable the “Are you sure you want to open this application?” dialog
	defaults write com.apple.LaunchServices LSQuarantine -bool false
	# Enable highlight hover effect for the grid view of a stack (Dock)
	defaults write com.apple.dock mouse-over-hilite-stack -bool true
	# Set the icon size of Dock items to 36 pixels
	defaults write com.apple.dock tilesize -int 36


.PHONY: usage
usage:
	@echo
	@echo "Hi ${GREEN}${USER}!${NC} Welcome to ${RED}${CURRENT_DIR}${NC}"
	@echo
	@echo "${RED}First things first:${NC}"
	@echo "  VPN(via AppStore or Package Manager)"
	@echo "  Pass Manager(can be via AppStore or package manager, AppStore can provide better integrations on Macs)."
	@echo "  same goes to Cron calendar app for Macs"
	@echo "  then install all apps, browsers, etc via package manager to have dependencies managed in one place"
	@echo
	@echo "${YELLOW}make xcode{NC}                     install xcode"
	@echo
	@echo "${YELLOW}make zsh${NC}                      install ZSH"
	@echo "${YELLOW}make zsh-syntax-highlighting${NC}  install ZSH syntax-highlighting"
	@echo "${YELLOW}make zsh-powershell10k${NC}        zsh-powershell10k(ensure to use UNICODE) OR to retry: 'p10k configure'"
	@echo
	@echo "${YELLOW}make brew-install${NC}             install brew"
	@echo "${YELLOW}make brew-browsers${NC}            brew web-browsers: FF, Chrome, Brace"
	@echo "${YELLOW}make brew-essentials${NC}          brew essential libraries(jq, git, openssl, etc)"
	@echo
	@echo "${YELLOW}make gpg-gen${NC}                  gpg generate"
	@echo "${YELLOW}make gpg-list${NC}                 gpg list"
	@echo "${YELLOW}make dotfiles-git${NC}             after gpg generation run zsh git script"
	@echo
	@echo "${YELLOW}make brew-extra${NC}               brew asdf, git-delta, batcat"
	@echo "${YELLOW}make brew-iterm${NC}               brew iTerm2"
	@echo
	@echo "${RED}Install Shell integration${NC}     setup shell integration - iTerm2 -> Install Shell Integration"
	@echo "${RED}Install tmux integration${NC}      change setting to open TMUX windows in native tabs: General -> TMUX -> dropdown: Native Tabs in new window"
	@echo "${RED}add script to enable iterm command click on files to open in your editor${NC}      refer Ruby script"
	@echo "${RED}change Profile -> General -> Working directory : Reuse previous session's directory${NC}"

	@echo
	@echo "${YELLOW}make brew-fzf${NC}                 brew fuzzy reverse search of commands"
	@echo "${YELLOW}make brew-neovim${NC}              brew neovim"
	@echo "${YELLOW}make brew-vscode${NC}              brew vscode"
	@echo
	@echo "${YELLOW}make brew-apps${NC}                brew below apps"
	@echo
	@echo "${YELLOW}make brew-discord${NC}             brew discord"
	@echo "${YELLOW}make brew-tuple${NC}               brew tuple"
	@echo "${YELLOW}make brew-zoom${NC}                brew zoom"
	@echo "${YELLOW}make brew-messengers${NC}          brew messengers: Slack, Signal, Telegram"
	@echo "${YELLOW}make brew-clouddrives${NC}         brew cloud drives: NextCloud, kDrive"
	@echo "${YELLOW}make brew-obsidian${NC}            brew Obsidian"
	@echo "${YELLOW}make brew-spotify${NC}             brew Spotify"
	@echo "${YELLOW}make brew-prusaslicer${NC}         brew Prusa Slicer for 3D printing"
	@echo
	@echo "${YELLOW}make gh-cli${NC}                   login GitHub CLI"
	@echo
	@echo "${YELLOW}make dotfiles${NC}                 IF HAVENT done already, pull dotfiles"
	@echo "${YELLOW}make dotfiles-install${NC}         zsh install.sh"
	@echo
	@echo "${YELLOW}make asdf-install${NC}             install ASDF package manager"
	@echo "${YELLOW}make asdf-ruby${NC}                install Ruby via asdf"
	@echo "${YELLOW}make ruby-gem-essentials${NC}      install Ruby essential gems"
	@echo
	@echo "${YELLOW}make readmore${NC}                 further options tweaks and scripts"
	@echo "${YELLOW}make mac-settings${NC}             sane mac settings scripts"
	@echo

