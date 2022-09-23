local addonName, addon = ...

LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0")

function addon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New(addonName .. "DBv1", {
        profile = {
            list = {}},
    })

    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptions())
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, nil, nil, "profiles")

    -- Add dual-spec support
    local LibDualSpec = LibStub('LibDualSpec-1.0')
    LibDualSpec:EnhanceDatabase(self.db, addonName)
    LibDualSpec:EnhanceOptions(self.options.args.profiles, self.db)

    -- Register Callbacks on certain events
    self:RegisterEvent("UPDATE_BINDINGS", "SaveProfile")
    self.db.RegisterCallback(self, "OnNewProfile", "SaveProfile")
    self.db.RegisterCallback(self, "OnProfileShutdown", "SaveProfile")
    self.db.RegisterCallback(self, "OnProfileChanged", "RestoreDbBindings")
    self.db.RegisterCallback(self, "OnProfileCopied", "RestoreDbBindings")
    self.db.RegisterCallback(self, "OnProfileReset", "RestoreDefaultBindings")
end