#!/bin/bash

set -e  # Exit on error

echo "[+] Updating package lists..."
sudo apt update

echo "[+] Installing dependencies..."
sudo apt install -y curl wget git zsh

echo "[+] Installing Homebrew..."
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo "[+] Installing Oh My Zsh..."
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "[+] Installing Oh My Posh..."
brew install oh-my-posh

echo "[+] Installing CascadiaMono Nerd Font..."
brew tap homebrew/cask-fonts
brew install --cask font-cascadia-code

echo "[+] Installing Atuin..."
brew install atuin

echo "[+] Installing WezTerm..."
brew install wezterm

echo "[+] Configuring WezTerm..."
mkdir -p $HOME/.config/wezterm/themes
cp $HOME/.shell/wezterm/themes/nord-dark.lua $HOME/.config/wezterm/themes/
cp $HOME/.shell/wezterm/themes/nord-light.lua $HOME/.config/wezterm/themes/
ln -sv $HOME/.shell/wezterm/wezterm.lua $HOME/.wezterm.lua

echo "[+] Setting up Oh My Posh theme..."
mkdir -p $HOME/.config/oh-my-posh
curl -o $HOME/.config/oh-my-posh/nr.nordic.k2.win.omp.json \
  https://raw.githubusercontent.com/Nickael/ohmyposh.theme/master/.nr.nordic.k2.win.omp.json

echo "[+] Configuring shell to use Oh My Posh..."
echo 'eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/nr.nordic.k2.win.omp.json)"' >> $HOME/.zshrc
echo 'eval "$(oh-my-posh init bash --config $HOME/.config/oh-my-posh/nr.nordic.k2.win.omp.json)"' >> $HOME/.bashrc

echo "[✓] Installation complete! Restart your terminal to apply changes."
