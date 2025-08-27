# whoiskai dotfiles
## Dot files setup

Make sure you cloned this repo into your $HOME directory via git

```bash
brew install stow
git clone git@github.com:whoiskai/dotfiles.git
cd dotfiles
stow --target=$HOME .
```

Things are not fully working yet at this point, follow the full setup

## Full setup

```bash
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
stow --target=$HOME .

# After setting up brew
# Install all brew packages
brew install --cask alacritty aws-vault font-fira-code-nerd-font raycast obsidian visual-studio-code google-chrome rectangle telegram

brew install git zoxide fd rg fzf antidote scmpuff terragrunt tmux jq smimesign git-delta fastfetch powerlevel10k

# Install zsh plugins
antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# Install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
# prefix + I (capital i)

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

## Alacritty configuration

```bash
git clone g clone https://github.com/alacritty/alacritty-theme.git ~/.config/alacritty/themes
```

Raycast settings
Applications -> Alacritty : Record hotkey for global hotkey.
