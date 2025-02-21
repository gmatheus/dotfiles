# Dotfiles

This repository contains my personal configuration files (dotfiles) and a [setup script](#setup) to install and configure my development environment for various tools and applications. These include shell enhancements, package managers, and other utilities to streamline my macOS development workflow:

- [Oh My Zsh](https://ohmyz.sh/) with [agnoster](https://github.com/agnoster/agnoster-zsh-theme) theme and custom prompt
- zsh plugins ([zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions))
- [Homebrew](https://brew.sh/)
- [nvm](https://github.com/nvm-sh/nvm) with [autoload](https://github.com/nvm-sh/nvm?tab=readme-ov-file#zsh) configuration
- [Node.js](https://nodejs.org/en/download) LTS version
- [saml2aws](https://github.com/Versent/saml2aws)
- Custom commands and aliases

## Setup

To set up your environment using these dotfiles, follow the instructions below:

1. Clone the repository to your home directory:

   ```sh
   git clone https://github.com/gmatheus/dotfiles.git ~/.dotfiles
   ```

2. Navigate to the cloned repository:

   ```sh
   cd ~/.dotfiles
   ```

3. Run the setup script to create symlinks and configure your environment:

   ```sh
   sh ./setup.sh
   ```

   > ⚠️ **Note:** Running this script will overwrite your existing `.zshrc` file with the configuration from `.dotfiles/.zshrc`. A backup of your original `.zshrc` file will be saved as `~/.zshrc.bkp-*` for restoration if needed.

## Uninstall

If you want to remove the applications installed and revert your environment state, you can run the uninstall script. This is useful if you want to test the setup script from scratch.

1. Run the uninstall script to restore your original environment state:

   ```sh
   sh ./uninstall.sh
   ```

   > ⚠️ **Note:** The script does not automatically restore your original `.zshrc` file. To restore it, use the backup located at `~/.zshrc.bkp-*`.

Once done, you can run the setup script again to set up your environment.

## Customization

Feel free to customize the dotfiles to suit your preferences. You can edit the files directly in the repository and re-run the setup script to apply the changes.

## Contributing

If you have any improvements or suggestions, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
