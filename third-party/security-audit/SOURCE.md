# Source

- **Original:** https://github.com/cloudflare/security-audit-skill (`skills/security-audit/`)
- **Author:** Cloudflare, Inc.
- **License:** MIT (see `LICENSE` in this folder)
- **Pinned commit:** `c1c8a8c1471069fb0e188eeaff69b8e8db6564a8`
- **Copied:** 2026-11-16, files unmodified

## Why it's copied instead of linked

It's a standalone skill, not a Claude Code plugin, so there's no plugin manager keeping it updated. Pinning a reviewed commit means I know exactly which instructions my agent follows during a security audit.

Reviewed before copying: the two validator scripts (`validate-findings.cjs`, `validate-coverage-ledger.cjs`) use only Node built-ins (`fs`, `path`, `util`), with no network access and no child processes.

## Updating

Check the original repo for changes, review the diff, then replace the files in this folder and update the pinned commit above.
