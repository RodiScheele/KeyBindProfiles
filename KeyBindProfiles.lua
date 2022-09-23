local addonName, addon = ...

LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0")

function addon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New(addonName .. "DBv1", {
        profile = {
            minimap = { hide = false, },
            list = {}},
    })

    self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject(addonName, {
        type = "launcher",
        icon = "Interface\\ICONS\\INV_Misc_Punchcards_White",
        label = addonName,
        OnClick = function(obj, button)
            InterfaceOptionsFrame_OpenToCategory(addonName)
        end,
        OnTooltipShow = function(tooltip)
			if not tooltip or not tooltip.AddLine then return end
			tooltip:AddLine("KeyBindProfiles")
			tooltip:AddLine("Current profile: "..self.db:GetCurrentProfile())
		end
    })
    
    self.icon = LibStub("LibDBIcon-1.0")
    self.icon:Register(addonName, self.ldb, self.db.profile.minimap)

    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptions())
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, "KeyBindProfiles", nil, "minimap")
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, "Profiles", "KeyBindProfiles", "profiles")

    -- dual-spec support
    local LibDualSpec = LibStub('LibDualSpec-1.0')
    LibDualSpec:EnhanceDatabase(self.db, addonName)
    LibDualSpec:EnhanceOptions(self.options.args.profiles, self.db)

    -- Register Callbacks on certain events
    --self:RegisterEvent("UPDATE_BINDINGS", "SaveProfile")
    self.db.RegisterCallback(self, "OnProfileShutdown", "SaveProfile")
    self.db.RegisterCallback(self, "OnProfileChanged", "RestoreDbBindings")
    self.db.RegisterCallback(self, "OnProfileCopied", "RestoreDbBindings")
    self.db.RegisterCallback(self, "OnProfileReset", "RestoreDefaultBindings")
    self.db.RegisterCallback(self, "OnNewProfile", "SaveProfile")
end