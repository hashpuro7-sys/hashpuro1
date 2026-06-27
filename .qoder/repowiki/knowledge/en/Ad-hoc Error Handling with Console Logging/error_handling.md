## Overview

This Discord bot uses an **ad-hoc, inline error handling** approach based entirely on JavaScript's native `try/catch` blocks combined with `console.error()` / `console.log()` for diagnostics. There is no centralized error-handling framework, custom error types, middleware, or structured logging library.

---

## System and Approach

### Core Pattern: Try/Catch + Console Logging

All error handling follows a uniform pattern:

1. **Wrap risky operations** in `try/catch` blocks.
2. **Log errors to console** using `console.error()` (for failures) or `console.log()` (for informational state changes).
3. **Return user-facing messages** via `message.reply()` with emoji-prefixed strings (e.g., `❌ Erro ao...`).
4. **Graceful degradation**: On failure, the bot continues running rather than crashing.

### No Custom Error Types

The codebase does not define any custom error classes, error codes, or sentinel error values. All errors are handled as generic `Error` objects caught by `catch` blocks.

### No Panic/Recover Strategy

There is no global unhandled-rejection handler, no `process.on('uncaughtException')`, and no panic/recover mechanism. If an unhandled exception escapes all try/catch blocks, the Node.js process will crash.

---

## Key Files and Locations

| File | Role in Error Handling |
|------|------------------------|
| `index.js` | Main bot entry point; handles file I/O errors (`loadAds`, `saveAds`), command execution errors (music commands wrapped in try/catch), channel-send failures in `!sendads`, and login failures via `.catch()` on `client.login()`. |
| `music.js` | Music playback module; handles stream errors, player errors, connection errors, and search/validation failures. Uses event listeners (`player.on('error')`, `connection.on('error')`, `stream.on('error')`) for async error capture. |
| `config.js` | Loads environment variables via `dotenv`; no explicit error handling — relies on `dotenv`'s default behavior (silently ignores missing `.env` files). |

---

## Architecture and Conventions

### 1. File I/O Error Handling (`index.js`)

```javascript
function loadAds() {
  try {
    const data = fs.readFileSync(ADS_FILE, 'utf8');
    return JSON.parse(data);
  } catch (error) {
    console.error('Erro ao carregar anúncios:', error);
    return { ads: [] };  // Graceful fallback
  }
}
```

- **Pattern**: Catch → log → return safe default.
- Ensures the bot never crashes due to missing or corrupt `ads.json`.

### 2. Command-Level Error Wrapping (`index.js`)

Every music command invocation is wrapped identically:

```javascript
case 'skip':
  try { return music.skip(message); } 
  catch (err) { console.error(err); return message.reply('❌ Erro ao pular!'); }
```

- **Pattern**: Catch → log → reply with generic error message.
- User receives a localized Portuguese error string; developer sees raw error in console.
- No error context (command name, user, guild) is included in the log beyond what `console.error` prints by default.

### 3. Batch Operation Error Handling (`!sendads` in `index.js`)

```javascript
for (const channelId of AD_CHANNEL_IDS) {
  try {
    const channel = await client.channels.fetch(channelId.trim());
    // ... send ads ...
    successCount++;
  } catch (error) {
    console.error(`Erro ao enviar para canal ${channelId}:`, error.message);
    failCount++;
  }
}
```

- **Pattern**: Per-item try/catch within a loop; accumulate success/fail counts.
- One channel failure does not abort the entire batch.
- Only `error.message` is logged (not full stack trace), reducing debuggability.

### 4. Async Event-Based Error Handling (`music.js`)

```javascript
connection.on('error', (error) => {
  console.error('❌ Erro na conexão de voz:', error);
});

player.on('error', (error) => {
  console.error('❌ Erro no player:', error);
  queue.songs.shift();
  playNext(msg.guild.id);  // Auto-skip to next song
});

stream.on('error', (err) => {
  console.error('❌ Erro no stream:', err.message);
});
```

- **Pattern**: Register error event listeners on async resources (voice connection, audio player, YouTube stream).
- Player errors trigger automatic recovery (skip to next song).
- Stream errors are logged but do not trigger recovery — the stream simply fails silently.

### 5. Login Failure Handling (`index.js`)

```javascript
client.login(TOKEN).catch((err) => {
  console.error('❌ Erro ao conectar o bot:', err.message);
  console.error('Verifique se o token no arquivo .env está correto.');
});
```

- **Pattern**: Promise `.catch()` with actionable troubleshooting hint.
- Only `err.message` is logged; full stack trace is omitted.

### 6. Input Validation via Early Returns

Rather than throwing errors, invalid input is handled with guard clauses:

```javascript
if (!voiceChannel) return msg.reply("❌ Entre em um canal de voz!");
if (!queue) return msg.reply("❌ Nada tocando!");
if (!song || typeof song !== 'string') return msg.reply("❌ URL da música inválida!");
```

- **Pattern**: Validate → return user-friendly message.
- Prevents errors from occurring in the first place.

---

## Rules Developers Should Follow

### Conventions

1. **Always wrap async/risky operations in try/catch.** Never let exceptions propagate uncaught.
2. **Log with `console.error()` for failures**, `console.log()` for informational state changes.
3. **Reply to users with emoji-prefixed Portuguese messages** (e.g., `❌ Erro ao...`, `✅ Sucesso`).
4. **Use graceful fallbacks** where possible (e.g., return empty array on file read failure).
5. **Register error event listeners** on all async resources (players, connections, streams).

### Constraints

1. **No custom error types exist.** Do not introduce them without a repo-wide refactor.
2. **No global error handler exists.** Unhandled rejections will crash the process.
3. **Stack traces are rarely logged.** Most catches log only `error.message` or the raw error object (which may or may not include a stack, depending on Node.js version and error type).
4. **No structured logging.** Logs are plain text with emoji prefixes; there is no log level management, no log rotation, and no external log aggregation.

### Anti-Patterns to Avoid

1. **Do not swallow errors silently.** Every catch block should log something.
2. **Do not throw custom errors** unless you also add a global handler to catch them.
3. **Do not rely on `process.exit()`** for error recovery — the bot is designed to stay online indefinitely.
4. **Do not expose raw error details to end users.** User-facing messages are always sanitized emoji-prefixed strings.

---

## Summary

This codebase employs a **minimalist, ad-hoc error handling strategy** suitable for small-scale bots:

- **Strengths**: Simple, easy to understand, resilient to individual operation failures.
- **Weaknesses**: No centralized error tracking, limited debuggability (sparse stack traces), no global crash protection, no structured logging for production monitoring.

For a hobby or small-community bot, this approach is adequate. For production use at scale, consider adding:
- A global `process.on('unhandledRejection')` handler.
- Structured logging (e.g., `pino`, `winston`).
- Custom error classes with error codes.
- An error-reporting service (e.g., Sentry).
