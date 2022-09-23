local addonName, addon = ...

LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0")

function addon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New(addonName .. "DBv1", {
        profile = {
            list = {}},
    })

    self:RegisterChatCommand("kbp", "OnChatCommand")
    self.db.RegisterCallback(self, "OnNewProfile", "SaveProfile")
    self.db.RegisterCallback(self, "OnProfileShutdown", "SaveProfile")
    self.db.RegisterCallback(self, "OnProfileChanged", "RestoreDbBindings")
    self.db.RegisterCallback(self, "OnProfileCopied", "RestoreDbBindings")
    self.db.RegisterCallback(self, "OnProfileReset", "RestoreDefaultBindings")

    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptions())

    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, nil, nil, "profiles")
end

