# dotfiles

These are my personal dotfiles that I use to maintain all of the systems I have.

They are version-controlled via `yadm` for simplicity. To get going on a system simply clone this repo via:

```bash
yadm clone git@github.com:connor-duffin/dotfiles.git
```

which should set you up with the current latest version at HEAD.

I currently use the following tools:

- `zsh` as my shell, with `oh-my-zsh`.
- `VSCode` as my editor, with `neovim` for quick edits.
- `tmux` as my terminal multiplexer.
- `iTerm2` and `alacritty` as my terminal emulators.

## Manual interventions

Bundled in here are some files that you will need to do some manual intervention to get setup.

### VS Code

VS Code on macOS reads its settings from `~/Library/Application Support/Code/User/`.
The tracked copy lives in `~/.config/Code/User/`, so the macOS location needs to
be symlinked to it.

1. Quit VS Code. If it has already created its own `settings.json`, back it up,
   then link the tracked copy:

   ```bash
   VSC="$HOME/Library/Application Support/Code/User"
   mkdir -p "$VSC"
   [ -f "$VSC/settings.json" ] && [ ! -L "$VSC/settings.json" ] && \
     mv "$VSC/settings.json" "$VSC/settings.json.bak"
   ln -sfn ~/.config/Code/User/settings.json "$VSC/settings.json"
   ```

2. Check the link with `ls -l "$VSC"`. `settings.json` should point to
   `~/.config/Code/User/settings.json`.

3. Leave Settings Sync **off**: git is the source of truth. If you sign in for
   Copilot or GitHub, decline the prompt to turn Sync on.

Notes:

- Settings changed through the UI are written straight to the tracked file, so
  check `yadm diff` before committing!
- The R format-on-save setting expects the [air](https://posit-dev.github.io/air/)
  formatter and its VS Code extension to be installed.

### iTerm2

iTerm2 keeps its settings in `~/Library/Preferences`, which shouldn't be tracked
or symlinked. Instead, iTerm2 is pointed at the tracked folder
`~/.config/iterm2/`.

1. Install the font used in the profile (same as for VS Code, above).

2. Open **iTerm2 → Settings → General → Settings** and:
   - tick **Load settings from a custom folder or URL**
   - set the folder to `~/.config/iterm2`
   - set **Save changes** to **Automatically**

3. Quit and relaunch iTerm2. The tracked profile and colour scheme should now
   load.

Notes:

- If iTerm2 asks whether to overwrite the custom folder with your current
  settings on a fresh machine, choose **No**. Otherwise the defaults replace
  the tracked file.
- The plist also records window positions and other state, so check
  `yadm diff` before committing.
