# QuietValeera

Fed up with hearing the same emotes from Valeera?

An efficient, lightweight, high-performance World of Warcraft addon that silences Valeera.

## Why use this?

<strong><span style="color:#ba372a">TL;DR</strong></span> <span style="color:#2dc26b">reduced distractions while Delving in Midnight.</span>

## Key features

Simple, fast, and effciient silencing of Valeera.

## Installation

1. Move/copy the `QuietValeera` folder to your `_retail_/Interface/AddOns/` directory
2. Restart World of Warcraft or logout and login

On load/login, the addon mutes a set of Valeera voice/sound effect IDs so the emotes are silent for the session.

## Configuration

The addon requires no set up.

## Technical details

- **Event-based mute:** uses a frame listening for `PLAYER_LOGIN` and runs once per login.
- **MuteSoundFile loop:** iterates through a static list of Valeera sound IDs and mutes each one via `MuteSoundFile(id)`.
- **One-time execution:** `muted` flag prevents repeated re-muting if the event fires more than once.
- **Memory frees:** after muting, the sound ID table is set to `nil` to release memory.
- **Tiny footprint:** only one table (for sound IDs), one small function, and a single frame, ~2KB of RAM usage in total.

### Event handling

`QuietValeera` registers:

- `PLAYER_LOGIN`: triggers `MuteSounds()` once on login.

`MuteSounds()` behavior:

1. returns early when `muted` is already true.
2. loops `soundIDs` and calls `MuteSoundFile(id)` for each item.
3. sets `muted = true`.
4. sets `soundIDs = nil` to free the ID list.

## Contributing

Contributions to improve this tool are welcome! To contribute:

1. Fork the repository
2. Create a feature branch
3. Make your changes to the source code or documentation
4. Test with various class configurations and buff scenarios
5. Submit a pull request with a clear description of the improvements

Please ensure your changes maintain compatibility with existing functionality and follows Lua best practices.

## Bugs and new features

Found a bug or want to submit a feature request?
[open an issue here](https://github.com/ExponentiallyDigital/QuietCraft/issues)

## Support

This tool is unsupported and may cause objects in mirrors to be closer than they appear etc. Batteries not included.

## License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

Copyright (C) 2026 ArcNineOhNine
