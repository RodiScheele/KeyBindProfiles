Key Bind Profiles
===================

Blizzard only allows you to save character specific keybinds. I wanted an addon that could provide specialization specific keybinds with full automation. For that reason I created this addon.

This addon allows you to save your keybind settings into different profiles, to be loaded and used again later. Each profile can be assigned to a specialization such that it automatically loads upon switching specs.

Originally I wanted to port Silencer2K his action-bar-profiles to wotlk for it's keybind profile functionality. However, a lot of API calls from that addon are not yet implemented in the wotlk API's. After stripping down the codebase to a working version I decided that rewriting and simplifying the keybind saving logic into a new addon was wiser. The only logic left from Silencer2K his original addon is the keybind saving and loading aspect, the rest of this addon is a complete rewrite.

How to use
-----

Save and load profiles from the addon's interface menu.

**Auto save keybinds on change is disabled by default**. This means that you have to manually save your profiles each time you make a change to your keybinds. Enabling this option allows any changes made to your keybinds to be automatically saved to the profile, thus not requiring the need to save the profile manually.

Quitting the game will always keep the most recently loaded profile in the game's default setting.

Storage and backup
-----
If you delete your WTF folder in your wow directory all saved keybind profiles will be wiped. The file storing and containing all keybind settings is located in this wow directory: ```/World of Warcraft/_classic_/WTF/Account/ACCOUNTNAME/SavedVariables/KeyBindProfiles.lua. Keep a backup of this file if you want to keep your keybinds safe, if you reinstall wow place this file back into this folder to restore your old keybind settings.

It is wise to make backup profiles, in case you accidentally clear/overwrite an important profile or if the addon behaves in unexpected ways.

Compatability
-----

This addon has been tested with
* Default Action Bars
* Bartender
* Dominos

I haven't tried other action bar addons, it should work as long as an addon doesn't rewrite the base action bar logic.

Azaiko's links
-----

* Source code [https://github.com/rscheele/Key-bind-profiles-Azaiko](https://github.com/rscheele/Key-bind-profiles-Azaiko)
* CurseForge [https://www.curseforge.com/wow/addons/keybindprofiles](https://www.curseforge.com/wow/addons/keybindprofiles)
* Wowinterface [https://www.wowinterface.com/downloads/info26417-KeyBindProfiles.html](https://www.wowinterface.com/downloads/info26417-KeyBindProfiles.html)
* Wago [https://addons.wago.io/addons/key-bind-profiles-azaiko-classic-wotlk](https://addons.wago.io/addons/key-bind-profiles-azaiko)

Original links to Silencer2K his addon
-----

* The latest release is available on [https://www.curseforge.com/wow/addons/action-bar-profiles](https://www.curseforge.com/wow/addons/action-bar-profiles)
* The latest alpha build is available on [http://www.wowace.com/addons/action-bar-profiles/files](http://www.wowace.com/addons/action-bar-profiles/files)
* The source code is available on [https://github.com/Silencer2K/wow-action-bar-profiles](https://github.com/Silencer2K/wow-action-bar-profiles)
* My other add-ons are available on [https://www.curseforge.com/members/silencer2k/projects](https://www.curseforge.com/members/silencer2k/projects)
