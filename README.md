# Prerequisite for NeoVim

## 1. latest nvim 

`apt install neovim` won't cut it as it installs some ancient v like 0.6.1, while the latest was 0.9.1

```sh
asdf plugin add neovim
asdf install neovim latest
asdf global neovim latest
```

## 2. REQUIRES 'ripgrep' !!!!
https://github.com/BurntSushi/ripgrep

asdf plugin add ripgrep
asdf install ripgrep latest
asdf global ripgrep latest

## Toolset

- [oh-my-zsh](http://ohmyz.sh/)
- [git](https://git-scm.com/)

## Fonts
https://www.jetbrains.com/lp/mono/

```sh
unzip DOWNLOADED_FONT.zip
mkdir -p ~/.fonts
mv <FILEPATH_OF_FONT> ~/.fonts
fc-cache -f -v

 ```
