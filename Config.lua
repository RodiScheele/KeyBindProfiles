local addonName, addon = ...

function addon:GetOptions()
    self.options = self.options or {
        type = "group",
        args = {
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db),
        },
    }
    return self.options
end
