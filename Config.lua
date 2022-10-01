local addonName, addon = ...

function addon:GetOptions()
    self.options = self.options or {
        type = "group",
        args = {
            general_settings = {
                name = "General options",
                type = "group",
                args = {
                    minimap = {
                        order = 1,
                        name = "Minimap Icon",
                        desc = "Show a button next to the minimap.",
                        type = "toggle",
                        width = "full",
                        set = function(info, value)
                            self.db.global.minimap.hide = not value
                            if value then
                                self.icon:Show(addonName)
                            else
                                self.icon:Hide(addonName)
                            end
                        end,
                        get = function(info)
                            return not self.db.global.minimap.hide
                        end,
                    },
                    auto_save = {
                        order = 2,
                        name = "Auto save keybinds on change",
                        desc = "Automatically saves your keybinds to the active profile when you make changes, thus not requiring to press 'Save current profile anymore'.",
                        type = "toggle",
                        width = "full",
                        confirm = function(info, value)
                            if value then
                                self.db.global.auto_save.enabled = true
                                return "This setting is applied only after reloading your UI. Do you want to reload UI now?"
                            else
                                self.db.global.auto_save.enabled = false
                                return "This setting is applied only after reloading your UI. Do you want to reload UI now?"
                            end
                        end,
                        set = function(info, value)
                            ReloadUI();
                        end,
                        get = function(info)
                            return self.db.global.auto_save.enabled
                        end,
                    },
                    save_profile = {
                        order = 3,
                        name = "Save current profile",
                        desc = "Save your keybinds to the currently active profile manually. Not required when 'Auto save keybinds on change' is enabled.",
                        type = "execute",
                        width = "normal",
                        func = function()
                            self:SaveProfile()
                        end,
                    },
                },
            },
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db),
        },
    }
    return self.options
end
