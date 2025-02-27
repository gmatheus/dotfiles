#!/bin/sh
read -p "Are you sure you want to proceed with the uninstallation? (y/n): " confirm
if [ "$confirm" != "y" ]; then
  echo "Uninstallation aborted."
  exit 1
fi

echo "Uninstalling components from your Mac...\n"

echo "Uninstalling Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
  rm -rf "$HOME/.oh-my-zsh"
  echo "Done!\n"
else
  echo "Oh My Zsh is not installed. Skipping uninstallation.\n"
fi

echo "Uninstalling zsh plugins..."
ZSH_PLUGIN_DIRECTORY="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
ZSH_PLUGINS="zsh-syntax-highlighting zsh-autosuggestions"
for plugin in $ZSH_PLUGINS; do
  if [ -d "$ZSH_PLUGIN_DIRECTORY/$plugin" ]; then
    rm -rf "$ZSH_PLUGIN_DIRECTORY/$plugin"
    echo "$plugin uninstalled."
  else
    echo "$plugin is not installed. Skipping uninstallation."
  fi
done
echo ""

echo "Uninstalling Homebrew..."
if test $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
  echo "Done!\n"
else
  echo "Homebrew is not installed. Skipping uninstallation.\n"
fi

echo "Uninstalling nvm..."
if [ -d "$HOME/.nvm" ]; then
  rm -rf "$HOME/.nvm"
  echo "Done!\n"
else
  echo "nvm is not installed. Skipping uninstallation.\n"
fi

echo "Uninstalling Node.js..."
if command -v node >/dev/null 2>&1; then
  nvm uninstall --lts
  echo "Done!\n"
else
  echo "Node.js is not installed. Skipping uninstallation.\n"
fi

echo "Uninstalling AWS CLI..."
if command -v aws >/dev/null 2>&1; then
  sudo rm -rf /usr/local/aws-cli
  echo "Done!\n"
else
  echo "AWS CLI is not installed. Skipping uninstallation.\n"
fi

echo "Uninstalling saml2aws..."
if command -v saml2aws >/dev/null 2>&1; then
  brew uninstall saml2aws
  echo "Done!\n"
else
  echo "saml2aws is not installed. Skipping uninstallation.\n"
fi

echo "Now you can run \`sh ./setup.sh\` to set up your environment again.\n"
