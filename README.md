# whoiskai dotfiles
## Dot files setup

Make sure you cloned this repo into your $HOME directory via git

```bash
git clone git@github.com:whoiskai/dotfiles.git
cd dotfiles
```

Then use GNU stow to create the symlinks

```bash
brew install stow
# inside of $HOME/dotfiles
stow .
```

Things are not fully working yet at this point, follow the full setup

## Full setup

```bash
# After setting up brew
# Install all brew packages
brew install antidote scmpuff volta terragrunt tmux jq autojump smimesign git-delta
brew install --cask aws-vault font-fira-code-nerd-font iterm2

# Generate new SSH key for cloning this repo
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub | pbcopy
# Add new SSH key to Github

# Generate new GPG key
gpg --full-generate-key
# Get the key ID generated
gpg --list-secret-keys --keyid-format=long
# Export the key
gpg --armor --export KEY_ID
# Add new GPG key to Github

# Clone this repo
git clone git@github.com:whoiskai/dotfiles.git ~/
stow .

# Install zsh plugins
antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# Install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
# prefix + I (capital i)

volta install node

# Install iterm2 themes
# https://iterm2colorschemes.com/

# Remove dock delay and animation
defaults write com.apple.dock autohide-delay -float 0;
defaults write com.apple.dock autohide-time-modifier -int 0;
defaults write com.apple.dock launchanim -bool false;
# Remove windows resize time
defaults write -g NSWindowResizeTime -float 0.00;
# Remove quicklook animation time
defaults write -g QLPanelAnimationDuration -float 0;
killall Dock;
```

## iTerm2 configuration
Go to iTerm2 `General > Settings` and Load settings from a custom folder or URL
- `/Users/{USER}/dotfiles/System/iTerm/settings`
