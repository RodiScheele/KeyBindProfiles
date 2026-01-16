local addonName, addon = ...

LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0")

function addon:OnInitialize()
    -- Register DB
    self.db = LibStub("AceDB-3.0"):New(
        addonName .. "DBv1", {
            global = {
                minimap = { hide = false, },
                auto_save = { enabled = true, },
            }
        }
    )

    self.db.global.update_bindings_trigger = true

    -- Minimap icon
    self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject(addonName, {
        type = "launcher",
        icon = "Interface\\ICONS\\INV_Misc_Punchcards_White",
        label = addonName,
        OnClick = function(obj, button)
            Settings.OpenToCategory(optionsId)
        end,
        OnTooltipShow = function(tooltip)
			if not tooltip or not tooltip.AddLine then return end
			tooltip:AddLine("KeyBindProfiles")
			tooltip:AddLine("Current profile: ".. self.db:GetCurrentProfile())
		end
    })
    
    self.icon = LibStub("LibDBIcon-1.0")
    self.icon:Register(addonName, self.ldb, self.db.global.minimap)

    -- Options tables
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptions())
    frame, optionsId = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, "KeyBindProfiles", nil, "general_settings")
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, "Profiles", "KeyBindProfiles", "profiles")
	
    -- Dual-spec support
    pcall(function() self:LoadLibDualSpec() end)

	-- Chat commands
    self:RegisterChatCommand("kbp", "OnChatCommand")

end

function addon:LoadLibDualSpec()
    local LibDualSpec = LibStub('LibDualSpec-1.0')
    LibDualSpec:EnhanceDatabase(self.db, addonName)
    LibDualSpec:EnhanceOptions(self.options.args.profiles, self.db)
end

function addon:OnEnable()
    self:InitializeProfile()
    self:RestoreDbBindings()

    -- Register Callbacks on certain events
    self.db.RegisterCallback(self, "OnProfileChanged", "RestoreDbBindings")
    self.db.RegisterCallback(self, "OnProfileCopied", "RestoreDbBindings")
    self.db.RegisterCallback(self, "OnProfileReset", "RestoreDefaultBindings")
    self.db.RegisterCallback(self, "OnNewProfile", "SaveProfile")
    if self.db.global.auto_save.enabled then
        self:RegisterEvent("UPDATE_BINDINGS", "SaveProfile")
        self.db.RegisterCallback(self, "OnProfileShutdown", "SaveProfile")
        self.db.RegisterCallback(self, "OnDatabaseShutdown", "SaveProfile")
    end
end