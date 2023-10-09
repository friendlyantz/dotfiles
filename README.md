# Notes 

## How to install

just use `make`
```sh
❯ make

Hi friendlyantz! Welcome to dotfiles

First things first:
	Browsers Install: FF, Brave, Chrome, etc
	AppStore: Magnet, VPN, etc
	VPN, Pass Manager
Getting started as per https://github.com/lewagon/setup/blob/master/macos.md

make brew-install             install brew and xcode
make brew-essentials          brew essential apps
make brew-extra               brew asdf, git-delta, batcat
make brew-iterm               brew iTerm2
make brew-fzf                 brew fuzzy reverse search of commands
make brew-neovim              brew neovim
make brew-vscode              brew vscode
make brew-discord             brew discord
make brew-tuple               brew tuple
make brew-zoom                brew zoom

make zsh                      install ZSH
make zsh-syntax-highlighting  install ZSH syntax-highlighting

make gh-cli                   login GitHub CLI

make dotfiles                 IF HAVENT done already, pull dotfiles
make dotfiles-install         zsh install.sh
make zsh-powershell10k        zsh-powershell10k(ensure to use UNICODE) OR to retry: 'p10k configure'

make asdf-install             install ASDF package manager
make asdf-ruby                install Ruby via asdf
make ruby-gem-essentials      install Ruby essential gems

make readmore                 further options tweaks and scripts
make mac-settings           	sane mac settings scripts
```

## 2. RipGrep
https://github.com/BurntSushi/ripgrep

asdf plugin add ripgrep
asdf install ripgrep latest
asdf global ripgrep latest

## Fonts
https://www.jetbrains.com/lp/mono/

```sh
unzip DOWNLOADED_FONT.zip
mkdir -p ~/.fonts
mv <FILEPATH_OF_FONT> ~/.fonts
fc-cache -f -v

 ```
