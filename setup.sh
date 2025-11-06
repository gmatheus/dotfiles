#!/bin/sh
echo "Setting up your Mac...\n"

echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
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
  npm config set script-shell $(which zsh)
  echo "Done!\n"
else
  echo "Node.js already installed. Skipping installation.\n"
fi

echo "Installing Go..."
if ! command -v go >/dev/null 2>&1; then
  GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -1)
  GO_ARCH=$([ "$(uname -m)" = "x86_64" ] && echo "amd64" || echo "arm64")
  
  curl -LO "https://go.dev/dl/${GO_VERSION}.darwin-${GO_ARCH}.tar.gz"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "${GO_VERSION}.darwin-${GO_ARCH}.tar.gz"
  rm "${GO_VERSION}.darwin-${GO_ARCH}.tar.gz"
  echo "Done!\n"
else
  echo "Go already installed. Skipping installation.\n"
fi

echo "Installing golangci-lint..."
if ! command -v golangci-lint >/dev/null 2>&1; then
  export PATH="/usr/local/go/bin:$PATH"
  curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin
  echo "Done!\n"
else
  echo "golangci-lint already installed. Skipping installation.\n"
fi

echo "Installing AWS CLI..."
if ! command -v aws >/dev/null 2>&1; then
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
  rm AWSCLIV2.pkg
  echo "Done!\n"
else
  echo "AWS CLI already installed. Skipping installation.\n"
fi

echo "Installing saml2aws..."
if ! command -v saml2aws >/dev/null 2>&1; then
  brew install saml2aws
  echo "Done!\n"
else
  echo "saml2aws already installed. Skipping installation.\n"
fi

# Backup .zshrc if it exists, then symlink the .dotfiles version
echo "Syncing .zshrc..."
if [ -e "$HOME/.zshrc" ]; then
  TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
  cp "$HOME/.zshrc" "$HOME/.zshrc.bkp-$TIMESTAMP"
  rm "$HOME/.zshrc"
  echo "Your .zshrc was backed up to $HOME/.zshrc.bkp-$TIMESTAMP"
fi
ln -sw "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
echo "Done!\n"

# Switch to zsh
echo "Done! Switching to zsh..."
exec zsh
