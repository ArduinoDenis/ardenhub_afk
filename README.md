# ArDenHub AFK System

A lightweight and configurable AFK (Away From Keyboard) detection system for FiveM servers.

## Overview

This script automatically detects when players are inactive and marks them as AFK. It monitors player movement, rotation, and input actions to determine activity status.

## Features

- Automatic AFK detection based on player movement and input
- Configurable AFK timeout duration
- Warning notification before being marked as AFK
- Periodic AFK status notifications
- Visual indicators for other players to see who is AFK
- Debug mode for testing and troubleshooting

## Requirements

- FiveM server
- ox_lib for notifications

## Installation

1. Download or clone this repository
2. Place the `ardenhub_afk` folder in your server's resources directory
3. Add `ensure ardenhub_afk` to your server.cfg
4. Ensure you have ox_lib installed and running on your server

## Configuration

The script includes several configuration options that can be adjusted in the `client.lua` file

### Configuration Options

| Option | Description |
|--------|-------------|
| afkTime | Time in seconds before a player is considered AFK |
| notificationInterval | How often (in seconds) to show AFK notifications |
| warningNotification | Whether to show a warning before being marked as AFK |
| warningTime | How many seconds before AFK status to show the warning |
| inputControl | Whether to monitor player input actions (not just movement) |
| debugMode | Enable debug messages in console |

## How It Works

1. The script continuously monitors player activity by checking:
   - Player position changes
   - Player heading (rotation) changes
   - Player input actions (if enabled)

2. When no activity is detected for the configured time period:
   - A warning notification is displayed (if enabled)
   - After the full AFK time, the player is marked as AFK
   - An "AFK" indicator is shown above the player using the `/me` command
   - Periodic notifications remind the player they are in AFK mode

3. When activity is detected again:
   - The AFK status is automatically removed

## License

This script is released under the MIT License.

## Credits

Developed by ArduinoDenis.it

## Support
For support, contact [**ArDenHub**](https://discord.ardenhub.it) in the discord or open an issue on GitHub.