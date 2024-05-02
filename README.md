
# Key Bind Profiles Addon

**Key Bind Profiles** is a lightweight addon designed to improve the management of keybinds in World of Warcraft. Blizzard’s default system only allows for character-specific keybind settings. This addon extends functionality by allowing specialization-specific profiles that automatically load when you switch specializations.

## Features

- **Profile Management:** Create and save keybind settings into profiles that can be reloaded anytime.
- **Specialization-Specific Profiles:** Assign profiles to specific specializations for automatic loading upon switching.
- **Auto-Save Functionality:** Keybinds are automatically saved when changed, with the option to disable this feature for manual control.
- **Persistent Settings:** The profiles retain settings even after quitting the game.

## Usage

To manually manage profiles, through a macro for example, access the addon's interface menu or use the following chat commands:

- `/kbp save`: Saves the current profile.
- `/kbp save [profilename]`: Saves to a specified profile. Overwrites if it exists, or creates a new one.
- `/kbp load [profilename]`: Loads an existing profile.
- `/kbp delete [profilename]`: Deletes an existing profile.
- `/kbp list`: Lists all existing profiles.

Manual keybinds saving is available through the 'Save Keybinds' button or by using the `/kbp` command.

## Storage and Backup

Keybind settings are stored in the following directory:  
`/World of Warcraft/_<VERSION>/WTF/Account/<ACCOUNTNAME>/SavedVariables/KeyBindProfiles.lua`

**Important:** Deleting your WTF folder will remove all stored keybinds. To prevent loss of data, keep a backup of the `KeyBindProfiles.lua` file. If you reinstall the game, restore this file to retain your settings. **It's not possible to recover keybinds if you lose this file.**

## Compatibility

This addon has been tested and works with:
- Default Action Bars
- Bartender
- Dominos

It should be compatible with other action bar addons as long as they do not completely rewrite the base action bar logic.

## Development Background

The addon was created from a desire to port Silencer2K's action-bar-profiles addon for WotLK-classic. However, the original KeyBindProfiles contained a plethora of additional functionalities that ultimately caused the addon to break due to compatibility issues with WotLK's API.

Faced with numerous unimplemented API calls in WotLK, it became clear that a complete overhaul was necessary. I decided to extract and refine only the essential keybind saving and loading logic, discarding the rest. This decision led to the development of a new, streamlined addon that focuses solely on providing reliable keybind profile management.

The current addon, therefore, is a significant simplification and rewrite, maintaining only the core functionality of keybind management from Silencer2K's original work.

## Links

- **Source Code:** [GitHub](https://github.com/rscheele/KeyBindProfiles)
- **Download:**
  - [CurseForge](https://www.curseforge.com/wow/addons/keybindprofiles)
  - [WowInterface](https://www.wowinterface.com/downloads/info26417-KeyBindProfiles.html)
  - [Wago](https://addons.wago.io/addons/key-bind-profiles-azaiko-classic-wotlk)

For those interested in the original addon by Silencer2K:
- **Latest Release:** [CurseForge](https://www.curseforge.com/wow/addons/action-bar-profiles)
- **Alpha Build:** [WoWAce](http://www.wowace.com/addons/action-bar-profiles/files)
- **Source Code:** [GitHub](https://github.com/Silencer2K/wow-action-bar-profiles)

Explore more of Silencer2K’s projects on [CurseForge](https://www.curseforge.com/members/silencer2k/projects).
