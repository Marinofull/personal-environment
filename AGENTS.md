# Dotfiles — Agent Standards

## Purpose

One-shot setup for any new PC. Clone this repo, run `ruby install.rb`, answer the prompts, and the machine is ready. Every decision in this repo serves that goal.

---

## Security Policy

### Suspicion toward new open-source tools

Treat recently published or recently updated open-source tools as potentially compromised until they have had time for community scrutiny. Supply chain attacks often target the window between a project gaining popularity and the ecosystem catching up.

**Never install from `master` or `main`.** Always install a pinned release.

### 21-day cooldown rule

Before adding any new external tool, binary, or plugin to this repo:

1. Find the latest **stable** release (no release candidates, no dev/rc tags).
2. Check its publish date. It must be **at least 21 days old** from today.
3. Pin to that release — not to a branch, not to `latest`.

If no release clears the 21-day bar, wait. The next stable release will.

---

## Adding External Tools as Submodules

When a tool ships as source (skills, plugins, scripts), add it as a **git submodule pinned to the chosen stable tag**:

```bash
git submodule add https://github.com/<org>/<repo> <path>
cd <path> && git checkout <tag> && cd ..
git add <path> .gitmodules
git commit -m "add <tool> as submodule pinned to <tag>"
```

### Placement convention

- Submodules go at a **top-level non-hidden directory** named after the tool (e.g. `caveman_skill/`).
- Do not place them inside `skills/` directly — the skill scanner picks up everything there.
- Do not use a hidden directory — `install.rb` symlinks all hidden entries as dotfiles.

### Upgrade path

```bash
cd <submodule-path>
git checkout <new-tag>          # must be ≥21 days old
cd ..
git add <submodule-path>
# run any tool-specific update command (e.g. claude plugin update <name>)
git commit -m "bump <tool> to <new-tag>"
```

---

## Skills

Skills are directories containing a `SKILL.md` at their root. They are shared across Claude Code, Copilot, and Codex via symlinks.

### Source location

```
skills/
  <skill-name>/
    SKILL.md
```

### How they get wired

`install.rb` calls `install_skills(dest, label, skills_root)` from `installer/skills.rb` three times:

| Destination | Agent |
|---|---|
| `~/.codex/skills/<skill>` | Codex |
| `~/.copilot/skills/<skill>` | Copilot |
| `~/.claude/commands/<skill>` | Claude Code |

Each entry is a symlink: `~/.copilot/skills/<skill> → .dotfiles/skills/<skill>`.

### Skills from external submodules

When the skill SKILL.md lives inside a submodule (not at the submodule root), add a **git-tracked symlink** inside `skills/` pointing to the correct subdirectory:

```bash
ln -s ../<submodule-path>/<skill-subpath> skills/<skill-name>
git add skills/<skill-name>
```

`File.directory?` follows symlinks, so `install.rb` picks it up like any other skill.

---

## Build Pattern

Config files that contain **machine-specific absolute paths** must not be written directly to their destination. Instead:

1. **Template** lives in the repo at `<tool>/settings.json` (or similar).
2. **Build step** renders the template into `build/<tool>/settings.json`, substituting:
   - `{{DOTFILES_ROOT}}` → absolute path to this repo on the current machine
   - `{{HOME}}` → absolute path to the home directory
3. **Symlink** points the destination at the build artifact:
   `~/<tool>/settings.json → .dotfiles/build/<tool>/settings.json`

### Why

- The repo stays readable: templates are the source of truth, no machine-specific paths checked in.
- `build/` is gitignored — only generated artifacts live there.
- On a fresh machine, re-running `install.rb` regenerates and re-symlinks everything correctly.

### `build/` is gitignored

```
build/
```

Never commit anything from `build/`. If a config file needs to be tracked, track its **template**, not the rendered output.

---

## Installer Structure

```
install.rb              ← main entry point, prompts user, calls installer utils
installer/
  skills.rb             ← install_skills(dest, label, skills_root)
  claude_settings.rb    ← build template → build/, symlink to ~/.claude/settings.json
```

### Adding a new installer

1. Create `installer/<concern>.rb` with a method `install_<concern>(dotfiles_root)`.
2. Add `load "#{DOTFILES_ROOT}/installer/<concern>.rb"` near the top of `install.rb`.
3. Call the method in the appropriate place in `install.rb`.

---

## Claude Code — `settings.json`

Template: `claude/settings.json`
Built artifact: `build/claude/settings.json`
Live location: `~/.claude/settings.json` (symlink → build artifact)

Edit `claude/settings.json` in the repo. Re-run the installer (or just the build step) to apply.

---

## CLAUDE.md / AGENTS.md

`CLAUDE.md` is a symlink to `AGENTS.md`. Both filenames are recognized by different agents; one file, one source of truth.
