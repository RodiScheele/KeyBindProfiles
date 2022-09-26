Key Bind Profiles
===================

Blizzard only allows you to save character specific keybinds. I wanted an addon that could provide specialization specific keybinds, with full automation. For that reason I created this addon.

This addon allows you to save your keybind settings into different profiles, to be loaded again later. Each profile can be assigned to a specialization such that it automatically loads upon switching specs.

Originally I wanted to port Silencer2K his action-bar-profiles to wotlk for it's keybind profile functionality. However, a lot of API calls from that addon are not yet implemented in the wotlk API's. After stripping down the codebase to a working version I decided that rewriting and simplifying the keybind saving logic into a new addon was wiser. The only logic left from Silencer2K his original addon is the keybind saving and loading aspect, the rest is a total rewrite.

How to use
-------------

Save and load profiles from the addon's interface menu.

Auto save keybinds on change is disabled by default. This means that you have to save the profile manually each time you make a change to your keybinds. Enabling this option allows any changes made to your keybinds to be automatically saved to the profile, thus not requiring the need to save the profile manually anymore.

Note that this addon is best used on one computer and one single wow installation, using multiple computers might result in unexpected behaviours. 

Quitting the game will always keep the most recently loaded profile in the game's default setting.

It is wise to make backup profiles, in case you accidentally clear/overwrite an important profile.

Compatability
-----

This addon should work with at least
* Default Action Bars
* Bartender
* Dominos

Any other action bar addon has not been tested and is experimental.

Azaiko's links
-----

* Source code [https://github.com/rscheele/Key-bind-profiles-Azaiko-classic-wotlk](https://github.com/rscheele/Key-bind-profiles-Azaiko-classic-wotlk)


Original links to Silencer2K his addon
-----

* The latest release is available on [http://www.curse.com/addons/wow/action-bar-profiles](http://www.curse.com/addons/wow/action-bar-profiles)
* The latest alpha build is available on [http://www.wowace.com/addons/action-bar-profiles/files](http://www.wowace.com/addons/action-bar-profiles/files)
* The source code is available on [https://github.com/Silencer2K/wow-action-bar-profiles](https://github.com/Silencer2K/wow-action-bar-profiles)
* My other add-ons are available on [http://www.curse.com/users/silencer2k/projects](http://www.curse.com/users/silencer2k/projects)
