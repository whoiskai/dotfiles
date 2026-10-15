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
brew bundle install

# Install dev tools with mise
mise install

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

## Microsoft To Do CLI (`todo`)

`.local/bin/todo` adds and lists Microsoft To Do tasks through Microsoft Graph; `.claude/skills/todo/` tells Claude
Code to use it for reminders. Needs `uv` (Brewfile). The login is per machine, in the macOS Keychain.

```bash
# If a full stow conflicts, link just these two. Run from the repo root, wherever it's cloned
mkdir -p ~/.local/bin ~/.claude/skills
ln -sfn "$PWD/.local/bin/todo" ~/.local/bin/todo
ln -sfn "$PWD/.claude/skills/todo" ~/.claude/skills/todo

todo login   # device code sign-in; click "Always Allow" on the Keychain prompt

# Let Claude Code run the read-only commands without asking
python3 - <<'PY'
import json, pathlib
p = pathlib.Path.home() / ".claude/settings.json"
d = json.loads(p.read_text()) if p.exists() else {}
allow = d.setdefault("permissions", {}).setdefault("allow", [])
allow += [r for r in ["Bash(todo ls:*)", "Bash(todo ls)", "Bash(todo lists)", "Bash(todo --help)"] if r not in allow]
p.write_text(json.dumps(d, indent=2) + "\n")
PY
```
