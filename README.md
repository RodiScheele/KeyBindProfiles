Key Bind Profiles
===================

Blizzard only allows players to save character specific keybinds. I wanted an addon that could provide specialization specific keybinds with full automation. Which is why I created this addon.

This addon allows you to save keybind settings into different profiles, these profiles can be loaded and used again later. Each profile can be assigned to a specialization such that it automatically loads upon switching specs.

Originally I wanted to port Silencer2K his action-bar-profiles to wotlk for it's keybind profile functionality. However, a lot of API calls from that addon are not yet implemented in the wotlk API's. After stripping down the codebase to a working version I decided that rewriting and simplifying the keybind saving logic into a new addon was wiser. The only logic left from Silencer2K his original addon is the keybind saving and loading aspect, the rest of this addon is a complete rewrite.

How to use
-----

Save and load profiles from the addon's interface menu or use the chat commands from '/kbp'.

**Auto save keybinds on change is enabled by default**. This means that all changes made to keybinds are saved automatically. Disable this option if you want manual control over this, manually saving keybinds can be done by pressing the 'Save Keybinds' button or using the /kbp command.

Quitting the game will always keep the most recently loaded profile in the game's default setting.

Commands 
-----
Currently the following commands are supported:
* /kbp save -- Saves the current profile
* /kbp save profilename  -- Save to the specified profile. Overwrites existing profiles or creates a new profile if specified profile doesn't exist
* /kbp load profilename  -- Loads an existing profile
* /kbp delete profilename  -- Deletes an existing profile
* /kbp list -- Lists all existing profiles

Storage and backup
-----
Deleting your WTF folder in the wow directory deletes all stored key bindings. The file storing and containing all keybind settings is located in the following wow directory: `/World of Warcraft/_<VERSION>/WTF/Account/<ACCOUNTNAME>/SavedVariables/KeyBindProfiles.lua`. Keep a backup of this file if you want to keep your keybinds safe, if you reinstall wow place this file back into this folder to restore your old keybind settings.

Compatability
-----

This addon has been tested with
* Default Action Bars
* Bartender
* Dominos

I haven't tried other action bar addons, it should work as long as an addon doesn't rewrite the base action bar logic.

Azaiko's links
-----

* Source code [https://github.com/rscheele/KeyBindProfiles](https://github.com/rscheele/KeyBindProfiles)
* CurseForge [https://www.curseforge.com/wow/addons/keybindprofiles](https://www.curseforge.com/wow/addons/keybindprofiles)
* Wowinterface [https://www.wowinterface.com/downloads/info26417-KeyBindProfiles.html](https://www.wowinterface.com/downloads/info26417-KeyBindProfiles.html)
* Wago [https://addons.wago.io/addons/key-bind-profiles-azaiko-classic-wotlk](https://addons.wago.io/addons/key-bind-profiles-azaiko)

Original links to Silencer2K his addon
-----

* The latest release is available on [https://www.curseforge.com/wow/addons/action-bar-profiles](https://www.curseforge.com/wow/addons/action-bar-profiles)
* The latest alpha build is available on [http://www.wowace.com/addons/action-bar-profiles/files](http://www.wowace.com/addons/action-bar-profiles/files)
* The source code is available on [https://github.com/Silencer2K/wow-action-bar-profiles](https://github.com/Silencer2K/wow-action-bar-profiles)
* My other add-ons are available on [https://www.curseforge.com/members/silencer2k/projects](https://www.curseforge.com/members/silencer2k/projects)
