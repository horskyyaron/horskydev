# AGENTS

This repository is a small bootstrap for the Horskydev environment.
Scripts are mostly Bash and dotfile snippets; there is no application build.
Use the guidance below when editing or running tools.

## Repo map
- `boot.sh` clones the repo and kicks off installation.
- `install.sh` orchestrates the install steps and animations.
- `install/development/terminal.sh` installs terminal packages.
- `install/development/nvim.sh` clones the Neovim config.
- `install/config/config.sh` wires dotfiles into the user's home.
- `install/config/dotfiles/bash/.bashrc` holds bash aliases and PATH.
- `install/config/dotfiles/tmux/.tmux.conf` configures tmux.
- `bin/tmux-sessionizer.sh` opens tmux sessions via fzf.
- `bin/nvim-sessionizer.sh` opens the Horskyvim session.

## Build / lint / test
- There is no formal build step for this repo.
- There are no automated tests configured.
- There is no configured linter; use optional shell tooling if available.
- Syntax check a script with `bash -n path/to/script.sh`.
- Run ShellCheck manually if installed: `shellcheck path/to/script.sh`.
- Single-script check example: `bash -n bin/tmux-sessionizer.sh`.

## Install / run commands
- Bootstrap from a fresh machine: `./boot.sh`.
- Run install from an existing clone: `./install.sh`.
- Run just terminal tooling: `bash install/development/terminal.sh`.
- Run just Neovim config setup: `bash install/development/nvim.sh`.
- Apply dotfiles only: `bash install/config/config.sh`.
- tmux session switcher: `tmux-sessionizer.sh`.
- Neovim session switcher: `nvim-sessionizer.sh`.

## Platform assumptions
- Install scripts assume Arch Linux with `yay` available.
- `tmux-sessionizer.sh` includes Linux and macOS paths.
- SSH access to GitHub is required for cloning repos.

## Code style (Bash)
- Use Bash, not POSIX sh.
- Keep the shebang consistent with the file's neighbors.
- `#!/bin/bash` is used in install scripts.
- `#!/usr/bin/env bash` is used in `bin/` scripts.
- Match existing indentation in the file (mostly 4 spaces).
- Prefer `[[ ... ]]` tests over `[ ... ]`.
- Prefer `$(...)` over backticks for command substitution.
- Quote variables unless you intentionally want word splitting.
- Use `${var}` form inside strings or path concatenations.
- Keep functions small and focused.
- Use early exits for invalid state (see `tmux-sessionizer.sh`).
- Use `source` when wiring scripts together.
- Avoid heavy refactors that change the install flow.

## Naming conventions
- File names are lowercase with hyphens (e.g. `tmux-sessionizer.sh`).
- Keep script names descriptive and action oriented.
- Use uppercase for environment variables.
- Use lowercase for local variables.
- When adding new commands, keep them in `bin/` and update PATH only if needed.

## Imports and dependencies
- The install pipeline expects `git`, `curl`, `tmux`, and `tte`.
- `install/development/terminal.sh` uses `yay -S --noconfirm --needed`.
- `install/development/nvim.sh` clones `horskyvim` to `~/.config/horskyvim`.
- The bashrc loads Starship via `eval "$(starship init bash)"`.
- `boot.sh` removes `~/.local/share/horskydev/` before cloning.

## Formatting and output
- Use simple `echo` output; avoid noisy debug logs.
- Use `show_logo` and `show_subtext` helpers in `install.sh` when extending.
- Keep user-facing messages short and actionable.
- Do not add color codes unless already used.

## Error handling
- Existing scripts are permissive and do not enable `set -euo pipefail`.
- Only introduce strict modes if the script is designed for it.
- Check for missing selections and exit gracefully (see `tmux-sessionizer.sh`).
- Avoid destructive operations unless they are explicit and bounded.
- If you must remove files, use absolute paths and explain why.

## Dotfile behavior
- `install/config/config.sh` appends to `~/.bashrc` rather than replacing it.
- Avoid overwriting user dotfiles without a prompt.
- Keep the tmux plugin manager line at the bottom of `.tmux.conf`.

## tmux config conventions
- Keep theme and plugin settings grouped together.
- Key bindings are mostly normal mode (no prefix).
- When adding new key bindings, follow the existing style.

## Safety and security
- Do not commit secrets or tokens.
- Prefer SSH URLs only when the user has keys configured.
- If switching to HTTPS clone URLs, update docs consistently.

## Documentation expectations
- Update `AGENTS.md` if you change install flows or paths.
- Keep instructions short and command oriented.

## Notes for agentic tools
- This repo has no Cursor or Copilot rules at the time of writing.
- Follow the repo's Bash style and keep edits minimal.
- When uncertain, ask before making sweeping changes.

## Suggested checks before committing
- `bash -n` on any modified script.
- `shellcheck` on any modified script (if installed).
- Validate that scripts still run on the intended platform.

## Common pitfalls
- `boot.sh` deletes `~/.local/share/horskydev/` on every run.
- `install/development/terminal.sh` is Arch specific; avoid breaking it.
- `tmux-sessionizer.sh` uses `fzf`; ensure it is installed.
- `tmux-sessionizer.sh` uses `pgrep`; keep it available.
- The Neovim config clone assumes SSH keys.

## Quick reference
- Bootstrap: `./boot.sh`
- Install: `./install.sh`
- Terminal setup: `bash install/development/terminal.sh`
- Neovim setup: `bash install/development/nvim.sh`
- Dotfiles: `bash install/config/config.sh`
- tmux picker: `tmux-sessionizer.sh`
- Neovim picker: `nvim-sessionizer.sh`

## When adding new scripts
- Place user-invoked scripts in `bin/`.
- Use executable permissions and `#!/usr/bin/env bash`.
- Keep scripts portable between Linux and macOS when possible.
- Update `install/config/dotfiles/bash/.bashrc` if you add new key bindings.
- Update `AGENTS.md` with new commands.

## When editing install steps
- Keep the install order consistent: terminal tools, nvim, dotfiles.
- Use `show_logo` and `show_subtext` to preserve UX.
- Avoid changing remote URLs without user approval.
- Keep `YARON_DEV_INSTALL` path accurate.

## Testing single changes
- Prefer running the exact script you edited.
- Example: `bash install/config/config.sh`.
- Example: `bash -n install/config/config.sh`.
- Example: `shellcheck install/config/config.sh`.

## Style examples
- `if [[ -z $selected ]]; then exit 0; fi`.
- `tmux -u new-session -s $name -c $dir`.
- `echo "installing terminal stuff"`.

## End
- Keep this guide accurate and short for future agents.
