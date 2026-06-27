This repository uses **npm** as its primary dependency management system, leveraging standard Node.js conventions for declaring, versioning, and locking third-party libraries.

### 1. Dependency Declaration (`package.json`)
Dependencies are declared in `package.json` using **caret ranges** (`^`) for all production dependencies. This allows npm to automatically install the latest minor and patch versions that are backward-compatible, ensuring the bot receives security updates and non-breaking feature improvements without manual intervention.

Key dependencies include:
- **Discord Integration**: `discord.js` (^14.26.4) and `@discordjs/voice` (^0.19.2) for bot functionality and voice channel streaming.
- **Media Streaming**: `@distube/ytdl-core` (^4.16.12) and `play-dl` (^1.9.7) for handling YouTube audio extraction.
- **System Utilities**: `dotenv` (^17.4.2) for environment variable management and `ffmpeg-static` (^5.3.0) for providing a static FFmpeg binary.

### 2. Version Locking (`package-lock.json`)
The project maintains a `package-lock.json` (lockfileVersion 3), which pins the exact versions of every dependency and transitive dependency in the tree. This ensures **deterministic builds**, meaning that `npm install` will produce an identical `node_modules` structure regardless of when or where it is run. The lockfile resolves complex dependency graphs, such as the multiple versions of `undici` and `agent-base` required by different media libraries.

### 3. Vendoring and Exclusion Strategy
The `node_modules/` directory is explicitly excluded from version control via `.gitignore`. This is a standard practice to keep the repository lightweight, relying on the lockfile to reconstruct the environment. Additionally, sensitive configuration files (`.env`) and runtime data (`ads.json`) are also ignored to prevent accidental commits of secrets or stateful data.

### 4. Developer Conventions
- **Installation**: Developers should run `npm install` to populate `node_modules` based on the locked versions.
- **Updates**: To update dependencies, developers should use `npm update` or manually adjust versions in `package.json` followed by `npm install`, ensuring the lockfile is updated and committed alongside any code changes.
- **Scripts**: The `start` script (`node index.js`) is defined in `package.json`, providing a standardized entry point for running the bot.