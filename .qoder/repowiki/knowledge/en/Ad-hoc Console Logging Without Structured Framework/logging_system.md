## Overview

This Discord bot uses **no dedicated logging framework**. All logging is performed via raw Node.js `console` methods (`console.log`, `console.error`) scattered across two source files (`index.js` and `music.js`). There is no log-level management, no structured output format, no log rotation, and no centralized logger abstraction.

## Approach Used

### Bare `console.*` Calls

The entire application relies on:
- **`console.log()`** — used for informational messages (bot startup, voice channel joins, queue state changes, music additions).
- **`console.error()`** — used for error conditions (file I/O failures, connection errors, player errors, login failures).

No other console methods (`console.warn`, `console.debug`, `console.info`) are used. There is no distinction between severity levels beyond the choice of `log` vs `error`.

### No Logger Abstraction

There is no logger module, no wrapper function, and no configuration object for logging. Every file calls `console` directly. This means:
- Log output cannot be redirected to files or external services without modifying every call site.
- Log format is inconsistent — some messages include emojis, some include context (channel IDs, URLs), others do not.
- There is no timestamp prefix (relying on the runtime's default console behavior).
- There is no request/correlation ID or structured field support.

### Error Logging Patterns

1. **I/O operations** (`loadAds`, `saveAds` in `index.js`): Errors are caught and logged with `console.error()`, but `saveAds()` swallows errors silently without notifying the caller.
2. **Async command handlers**: Music commands wrap calls in `try/catch` and log via `console.error(err)` — sometimes logging only `err.message`, sometimes the full `err` object.
3. **Event listeners**: Voice connection state changes, player events, and stream errors all log via `console.log` or `console.error` inline.
4. **Bot login**: The top-level `.catch()` on `client.login()` logs the error message and a troubleshooting hint.

### Informational Logging

Informational `console.log` calls track operational state:
- Bot ready event with user tag and configured channel count.
- Voice channel join/leave events.
- Player state transitions (idle, playing).
- Queue mutations (song added, next song starting).
- Audio resource creation steps.

These logs use emoji prefixes (✅, 📢, 🔊, ⏹️, ▶️, 🎵, etc.) for visual scanning in terminal output.

## Key Files

- **`index.js`** — Contains ~15 `console` calls: startup info, ad file I/O errors, command handler errors, sendads per-channel failures, login failure.
- **`music.js`** — Contains ~15 `console` calls: voice connection state, player events, stream errors, queue operations, audio resource lifecycle.
- **`.qoder/repowiki/knowledge/en/Ad-hoc Error Handling with Console Logging/error_handling.md`** — Documents the ad-hoc error handling approach (though focused on error handling rather than logging architecture).

## Architecture and Conventions

### Decentralized, Inline Logging

Every module logs independently. There is no shared logger instance, no log configuration, and no convention for what gets logged. The pattern is purely reactive — log when something notable happens or when an error is caught.

### No Structured Fields

Log messages are free-form strings. There is no JSON structure, no key-value pairs, no consistent delimiter, and no machine-parseable format. This makes log aggregation or automated analysis impractical.

### No Log Level Strategy

The codebase uses only two effective levels:
- **INFO-equivalent**: `console.log()` for normal operations.
- **ERROR-equivalent**: `console.error()` for caught exceptions.

There is no DEBUG, WARN, or TRACE level. Developers cannot toggle verbosity at runtime.

### Emoji as Visual Categorization

Emojis serve as informal log categories:
- ✅ Success / confirmation
- ❌ Error / failure
- 📢 Announcement-related
- 🔊 Voice/audio-related
- 🎵 Music queue
- ⏹️/▶️ Player state

This is a terminal-friendly convention but has no semantic meaning to any tooling.

## Rules Developers Should Follow

1. **Use `console.error()` for all caught exceptions** — never swallow errors silently (current `saveAds()` violates this).
2. **Include contextual information** — log identifiers (channel ID, song URL, operation name) alongside error messages.
3. **Log full error objects, not just `.message`** — several call sites log only `err.message`, losing stack traces needed for debugging.
4. **Maintain emoji consistency** — if using emojis for visual scanning, follow the existing convention (✅ success, ❌ error, 🎵 music, 🔊 voice).
5. **Do not introduce a logging framework without team consensus** — the current approach is intentionally minimal; adding Winston, Pino, or similar would be a significant architectural change.
6. **For production deployments, consider redirecting stdout/stderr** — since there is no file logging built in, use process-level redirection (`node index.js > app.log 2>&1`) or a process manager (PM2) for log persistence.

## Limitations

- No log file output — all logs go to stdout/stderr only.
- No log rotation or retention policy.
- No ability to filter by level, module, or keyword at runtime.
- No correlation between related log entries (e.g., a single command's lifecycle).
- Stack traces are inconsistently logged (some sites log `err`, others log `err.message`).
- No integration with external monitoring or alerting systems.