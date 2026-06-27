## Configuration System Overview

This Discord bot uses a simple, file-based configuration approach centered on environment variables loaded via the `dotenv` npm package.

### Approach and Tools

- **Primary mechanism**: `.env` file parsed by `dotenv` (v17.4.2)
- **Entry point**: `require('dotenv').config()` at the top of `config.js` loads all key-value pairs from `.env` into `process.env`
- **No layered config**: There is no multi-environment support (e.g., dev/prod), no YAML/TOML/JSON config files for runtime settings, and no feature flag system

### Key Configuration Sources

1. **`.env`** — Stores sensitive and environment-specific values:
   - `DISCORD_TOKEN` — Bot authentication token (secret)
   - `AD_CHANNEL_IDS` — Comma-separated list of Discord channel IDs where ads are broadcast
   - `PREFIX` — Command prefix (defaults to `!` if not set)

2. **`ads.json`** — Acts as persistent data storage (not strictly configuration, but a file-backed state store). It holds the array of user-submitted advertisements and is read/written directly via `fs.readFileSync` / `fs.writeFileSync`.

3. **Hardcoded defaults in `config.js`** — When env vars are missing, fallbacks are applied inline:
   - `PREFIX` defaults to `'!'` via `process.env.PREFIX || '!'`
   - `AD_CHANNEL_IDS` defaults to an empty string, then split/filtered into an array
   - `DISCORD_TOKEN` has no fallback; absence causes login failure with an error message

### Architecture and Conventions

- **Flat, single-file architecture**: All configuration loading happens in `config.js`, which exports a simple object consumed by `index.js`. There is no dedicated `config/` directory or abstraction layer beyond this module.
- **Module-scoped config export**: `config.js` centralizes `process.env` access behind a CommonJS module export (`module.exports`), providing a single import point (`require('./config')`) rather than scattered `process.env` references throughout the codebase.
- **Comma-delimited list parsing**: `AD_CHANNEL_IDS` is stored as a comma-separated string in `.env` and parsed inline with `.split(',').filter(Boolean)`.
- **File-based persistence**: `ads.json` serves dual duty as both data store and implicit "configuration" of what ads exist. It is excluded from version control via `.gitignore`.
- **Secrets management**: The `.env` file contains the Discord bot token and is listed in `.gitignore` to prevent accidental commits. However, there is no validation, encryption, or secrets manager integration.

### Rules Developers Should Follow

1. **Never commit `.env`**: It is gitignored for a reason. Each developer/deployment must provide their own `.env` with valid `DISCORD_TOKEN` and desired `AD_CHANNEL_IDS`.
2. **Use comma-separated IDs for `AD_CHANNEL_IDS`**: Multiple channel IDs must be separated by commas with no spaces (spaces are not trimmed beyond the initial split filter).
3. **Set `DISCORD_TOKEN` before running**: The bot will fail to start without a valid token. No default or placeholder is provided.
4. **Do not manually edit `ads.json`**: This file is managed programmatically by the bot's command handlers. Manual edits risk JSON corruption.
5. **No environment layering**: If different environments (dev, staging, prod) are needed, developers must maintain separate `.env` files externally or use deployment-specific environment variable injection.
6. **Prefix customization**: Change `PREFIX` in `.env` to alter the command trigger character. The default is `!`.