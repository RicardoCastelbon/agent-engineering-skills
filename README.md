# Agent Engineering Skills

My working library of skills for AI coding agents (Claude Code): the ones I use day to day, the ones I'm trying out, and the ones I plan to build.

Each skill gets a short note about why I use it and what it changed in how my agents behave.

## Catalog

### Frontend

| Name | Type | Status | Source | What it's for | Why I use it |
|------|------|--------|--------|---------------|--------------|
| [impeccable](https://github.com/pbakaus/impeccable) | plugin: 1 skill, 24 commands | active | third-party (Paul Bakaus) | Design, critique, audit and polish frontend UI (`/impeccable audit`, `/impeccable polish`, …) | Agent-built UIs tend to look generic; this gives the agent a design review pass and catches common anti-patterns before I see the result |
| [figma](https://github.com/anthropics/claude-plugins-official) | plugin: MCP server + 16 skills | active | third-party (Figma) | Figma ↔ code: design to code, code to Figma, Code Connect, design systems | The agent reads the actual design (spacing, tokens, components) instead of guessing from a screenshot |
| [playwright](https://github.com/anthropics/claude-plugins-official) | plugin: MCP server | active | third-party (Microsoft) | Browser automation: navigate, click, fill forms, screenshots | The agent checks its own UI changes in a real browser before telling me it's done |
| [modern-web-guidance](https://github.com/GoogleChrome/modern-web-guidance) | plugin: 2 skills | trying | third-party (Google Chrome) | Current web platform practices: modern browser APIs, CSS layout, performance, accessibility, built-in AI APIs; plus Chrome extensions (Manifest V3) | Agents default to outdated web patterns from their training data; this steers them to current APIs |

**Type:** `skill` = a skill folder in this repo · `plugin` = a Claude Code plugin installed from a marketplace (may bundle skills, commands and MCP servers)

**Status:** `active` = in regular use · `trying` = being evaluated · `retired` = no longer used (kept for reference)

**Source:** `mine` = written by me · `adapted` = based on someone else's work (credited in the skill's NOTES.md) · `third-party` = used as-is, see [third-party/](third-party/)

Planned skills live in [ideas.md](ideas.md) until they have a first version.

## Layout

```
skills/<name>/        skills I wrote or adapted
  SKILL.md            the skill itself (frontmatter name + description)
  NOTES.md            why I use it, what it improved
third-party/<name>/   others' skills I use, with their LICENSE and source
templates/skill/      starting point for a new skill
ideas.md              backlog of planned skills
install.ps1           links skills into ~/.claude/skills
```

## Install

The install script links every skill folder in `skills/` and `third-party/` into `~/.claude/skills/` using directory junctions. Edits in this repo take effect in Claude Code right away. No admin rights needed.

```powershell
./install.ps1              # link all skills
./install.ps1 -Uninstall   # remove only the links this repo created
```

Existing folders in `~/.claude/skills` that aren't links to this repo are never touched.

### Plugins

Third-party plugins are installed with Claude Code's plugin manager, not copied into this repo:

```powershell
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin marketplace add pbakaus/impeccable

claude plugin install impeccable@impeccable
claude plugin install figma@claude-plugins-official
claude plugin install playwright@claude-plugins-official
claude plugin install modern-web-guidance@claude-plugins-official
```

## Adding a skill

```powershell
Copy-Item templates/skill skills/<skill-name> -Recurse
# edit SKILL.md and NOTES.md, add a row to the catalog, then:
./install.ps1
```

## Principles

- A skill should hold knowledge the model doesn't already have: a specific procedure, a non-obvious gotcha, a convention. Generic advice stays out.
- The `description` decides when a skill triggers, so it gets the most care.
- No client or employer specifics. Company-specific skills stay in a private location.

## License

[MIT](LICENSE) for my own skills (`skills/`), templates and scripts. Third-party plugins and skills keep their original licenses.
