The project utilizes a standard Node.js execution environment managed via `npm` for dependency resolution and script execution. There are no dedicated build steps (e.g., compilation, bundling) or containerization configurations (Docker, Makefiles).

### Build & Execution Approach
- **Runtime**: Node.js (CommonJS modules).
- **Dependency Management**: `npm` using `package.json` and `package-lock.json`.
- **Execution Entry Point**: `index.js`, defined as the `main` field in `package.json`.
- **Start Script**: `npm start` executes `node index.js`.
- **Configuration**: Environment variables are loaded via `dotenv` from a `.env` file, parsed in `config.js`.

### Key Files
- `package.json`: Defines dependencies (`discord.js`, `@discordjs/voice`, `play-dl`, etc.) and the start script.
- `index.js`: Main application entry point.
- `config.js`: Handles environment variable loading and configuration export.
- `.env`: Stores sensitive credentials (Discord Token, Channel IDs), excluded from version control via `.gitignore`.
- `.gitignore`: Excludes `node_modules/`, `.env`, and local data files (`ads.json`).

### Conventions & Rules
- **No Build Step**: The project runs source files directly; no transpilation (TypeScript/Babel) or bundling (Webpack) is configured.
- **Environment Configuration**: All secrets and runtime configs must be set in `.env`; never commit this file.
- **Dependency Installation**: Run `npm install` before starting the bot to ensure all native dependencies (e.g., `ffmpeg-static`) are resolved.
- **Testing**: No automated test framework is configured; the `test` script in `package.json` returns an error by default.