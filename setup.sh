#!/bin/sh
echo "Setting up your Mac...\n"

echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Done!\n"
else
  echo "Oh My Zsh already installed. Skipping installation.\n"
fi

echo "Installing zsh plugins..."
ZSH_PLUGIN_DIRECTORY="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
mkdir -p "$ZSH_PLUGIN_DIRECTORY"
ZSH_PLUGINS="zsh-syntax-highlighting zsh-autosuggestions"
for plugin in $ZSH_PLUGINS; do
  if [ -d "$ZSH_PLUGIN_DIRECTORY/$plugin" ]; then
    echo "$plugin already installed. Skipping installation."
  else
    git clone https://github.com/zsh-users/$plugin.git "$ZSH_PLUGIN_DIRECTORY/$plugin"
    echo "Done!"
  fi
done
echo ""

echo "Installing Homebrew..."
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "Done!\n"
else
  echo "Homebrew already installed. Skipping installation.\n"
fi

echo "Installing nvm..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  \. "$HOME/.nvm/nvm.sh"
  echo "Done!\n"
else
  echo "nvm already installed. Skipping installation.\n"
fi

echo "Installing Node.js..."
if ! command -v node >/dev/null 2>&1; then
  nvm install --lts
  echo "Done!\n"
else
  echo "Node.js already installed. Skipping installation.\n"
fi

echo "Installing saml2aws..."
if ! command -v saml2aws >/dev/null 2>&1; then
  brew install saml2aws
  echo "Done!\n"
else
  echo "saml2aws already installed. Skipping installation.\n"
fi

# Backup .zshrc if it exists, then symlinks the .dotfiles version
echo "Syncing .zshrc..."
if [ -e "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc-bkp"
  echo "Your .zshrc was backed up to $HOME/.zshrc-bkp"
fi
ln -sw "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
echo "Done!\n"
