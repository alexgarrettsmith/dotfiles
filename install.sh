#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/alexgarrettsmith/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Rosetta
sudo softwareupdate --install-rosetta

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Moved out of Brewfile due to prefix
arch -arm64 brew install starship

# Add items to the Finder sidebar
mysides add Code file:///Users/alexgarrettsmith/Code
mysides add Tutorials file:///Users/alexgarrettsmith/Library/Mobile%20Documents/com~apple~CloudDocs/Tutorials

# Install PHP extensions with PECL
pecl install redis

# Install global Composer packages
/opt/homebrew/bin/composer global require laravel/installer laravel/valet beyondcode/expose

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install
valet park ~/Code

# Create a Sites directory
mkdir $HOME/Code

# Clone Github repositories
./clone.sh

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source .macos

# Set the user profile photo
sudo sh ./userphoto.sh alexgarrettsmith resources/alex.jpeg

# Set the desktop wallpaper
desktoppr ./resources/wallpaper.jpg
