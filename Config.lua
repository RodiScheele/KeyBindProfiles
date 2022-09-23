local addonName, addon = ...

function addon:GetOptions()
    self.options = self.options or {
        type = "group",
        args = {
            minimap = {
                name = "General settings",
                type = "group",
                args = {
                    minimap = {
                        order = 1,
                        name = "Minimap Icon",
                        type = "toggle",
                        width = "full",
                        set = function(info, value)
                            self.db.profile.minimap.hide = not value
                            if value then
                                self.icon:Show(addonName)
                            else
                                self.icon:Hide(addonName)
                            end
                        end,
                        get = function(info)
                            return not self.db.profile.minimap.hide
                        end,
                    },
                },
            },
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db),
        },
    }
    return self.options
end
