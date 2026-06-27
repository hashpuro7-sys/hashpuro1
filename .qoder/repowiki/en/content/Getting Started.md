# Getting Started

<cite>
**Referenced Files in This Document**
- [README.md](file://README.md)
- [package.json](file://package.json)
- [index.js](file://index.js)
- [config.js](file://config.js)
- [music.js](file://music.js)
- [.gitignore](file://.gitignore)
</cite>

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Create Your Discord Bot Application](#create-your-discord-bot-application)
5. [Configure Environment Variables](#configure-environment-variables)
6. [Verify Installation and Run the Bot](#verify-installation-and-run-the-bot)
7. [Common Setup Issues and Troubleshooting](#common-setup-issues-and-troubleshooting)
8. [Next Steps](#next-steps)

## Introduction
This guide helps you quickly set up and run the Discord bot locally. It covers prerequisites, installation, creating a bot application in the Discord Developer Portal, configuring environment variables, verifying the setup, and resolving common first-time issues. The bot supports two main features:
- Bulk announcement management across configured channels
- Music playback in voice channels using YouTube links or search terms

## Prerequisites
Before installing, ensure you have:
- Node.js version 16.9.0 or higher installed on your machine
- A Discord account with access to a server where you can add bots
- Permission to invite bots to the server (owner or administrator)

These requirements are essential for the bot to connect to Discord and operate correctly.

**Section sources**
- [README.md:38-43](file://README.md#L38-L43)

## Installation
Follow these steps to install the project locally:

1. Download or clone the project folder to your computer.
2. Open a terminal in the project directory and run:
   - Command: npm install
   - Purpose: installs all required dependencies automatically

Dependencies installed include:
- discord.js v14 (primary library for Discord API interactions)
- dotenv (loads environment variables from .env)
- Additional libraries for voice and audio streaming

After installation, the project is ready to configure and run.

**Section sources**
- [README.md:46-60](file://README.md#L46-L60)
- [package.json:14-21](file://package.json#L14-L21)

## Create Your Discord Bot Application
To use the bot, you must register it in the Discord Developer Portal and invite it to your server.

Step-by-step:
1. Go to the Discord Developer Portal and create a new application.
2. Under the Bot section, reset or view the token and copy it.
3. Enable the following privileged intents:
   - MESSAGE CONTENT INTENT (required to read messages)
   - SERVER MEMBERS INTENT (recommended)
   - PRESENCE INTENT (optional)
4. Save changes.
5. In OAuth2 > URL Generator:
   - Select the bot scope
   - Grant permissions:
     - Send Messages
     - Embed Links
     - Read Message History
     - Read Messages/View Channels
     - Connect (required for voice)
     - Speak (required for music)
   - Copy the generated URL and authorize it in your browser to add the bot to your server.

Important notes:
- Keep your token secure; it will not be shown again.
- Without the required intents and permissions, the bot will not respond to commands or send announcements.

**Section sources**
- [README.md:62-96](file://README.md#L62-L96)

## Configure Environment Variables
Create a .env file in the project root with the following keys:
- DISCORD_TOKEN: your bot’s token
- AD_CHANNEL_IDS: comma-separated list of text channel IDs (no spaces)
- PREFIX: command prefix (default is !)

How to get channel IDs:
- Enable Developer Mode in Discord desktop/web settings
- Right-click a channel and select Copy ID
- Paste the IDs into AD_CHANNEL_IDS separated by commas

Notes:
- The .env file is ignored by Git for security.
- Ensure the file is saved in UTF-8 encoding without BOM.

**Section sources**
- [README.md:99-137](file://README.md#L99-L137)
- [.gitignore:1-4](file://.gitignore#L1-L4)
- [config.js:1-7](file://config.js#L1-L7)

## Verify Installation and Run the Bot
After setting up .env, start the bot:

1. Open a terminal in the project directory.
2. Run: npm start
3. Confirm the bot is online and shows configured announcement channels in the console.

Expected console output indicates:
- Bot username and tag
- Number of configured announcement channels
- List of channel IDs

If you see an error about an invalid token, recheck the DISCORD_TOKEN value in .env.

**Section sources**
- [README.md:140-159](file://README.md#L140-L159)
- [index.js:50-54](file://index.js#L50-L54)
- [index.js:391-395](file://index.js#L391-L395)

## Common Setup Issues and Troubleshooting
Below are frequent problems and their solutions:

- Invalid token
  - Symptom: “Error: An invalid token was provided”
  - Fix: Re-copy the token from the Developer Portal and paste it into DISCORD_TOKEN without extra spaces or quotes.

- Missing privileged intents
  - Symptom: “Privileged intent(s) provided without allowing it as a developer option”
  - Fix: Enable MESSAGE CONTENT INTENT in the Bot settings and save changes.

- Missing channel permissions
  - Symptom: “Missing Permissions” when sending announcements
  - Fix: In the target channel, grant the bot:
    - View Channel
    - Send Messages
    - Embed Links
    - Read Message History

- Announcement channels not configured
  - Symptom: “!sendads says no channels configured”
  - Fix: Ensure AD_CHANNEL_IDS contains comma-separated numeric IDs with no spaces and refers to text channels.

- Environment file encoding issues
  - Symptom: “Cannot read properties of undefined (reading 'split')”
  - Fix: Save .env in UTF-8 without BOM and ensure the first line starts with DISCORD_TOKEN=.

- Bot appears online but does not respond to commands
  - Possible causes:
    - Wrong PREFIX in .env
    - Bot lacks View Channel permission
    - MESSAGE CONTENT INTENT disabled
  - Fix: Verify PREFIX, enable intents, and confirm permissions.

- Music commands not working
  - Symptom: “You need to be in a voice channel!” or “Already playing in another voice channel!”
  - Fix: Join a voice channel and try again; if already playing elsewhere, use !leave to disconnect the bot from the other channel.

- Cannot play music
  - Possible causes:
    - Invalid YouTube URL
    - Unavailable video
    - No search results
  - Fix: Try a valid YouTube URL or a more specific search term.

- Voice channel audio issues
  - Symptom: No sound or muted audio
  - Fix: Ensure the bot has Connect and Speak permissions in the voice channel and restart the bot after granting permissions.

**Section sources**
- [README.md:508-636](file://README.md#L508-L636)
- [index.js:391-395](file://index.js#L391-L395)

## Next Steps
Once the bot is running:
- Add announcements with !addad and review them with !myads
- Send announcements to configured channels using !sendads
- Manage your announcements with !removead and !clearads
- For music, join a voice channel and use !play with a YouTube URL or search term; use !skip, !stop, !pause, !resume, !queue, !loop, and !leave as needed

Remember to keep your token private and back up your ads.json file if you want to preserve announcements across deployments.