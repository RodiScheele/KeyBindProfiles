local addonName, addon = ...

LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0", "AceTimer-3.0", "AceEvent-3.0", "AceSerializer-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local DEBUG = "|cffff0000Debug:|r "

local qtip = LibStub("LibQTip-1.0")

function addon:cPrintf(cond, ...)
    if cond then self:Printf(...) end
end

function addon:cPrint(cond, ...)
    if cond then self:Print(...) end
end

function addon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New(addonName .. "DB" .. ABP_DB_VERSION, {
        profile = {
            minimap = {
                hide = false,
            },
            list = {},
            replace_macros = false,
        },
    }, ({ UnitClass("player") })[2])

    self.db.RegisterCallback(self, "OnProfileReset", "UpdateGUI")
    self.db.RegisterCallback(self, "OnProfileChanged", "UpdateGUI")
    self.db.RegisterCallback(self, "OnProfileCopied", "UpdateGUI")

    -- chat command
    self:RegisterChatCommand("abp", "OnChatCommand")

    -- settings page
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptions())

    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, nil, nil, "general")
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, self.options.args.profiles.name, addonName, "profiles")

    -- events
    self:RegisterEvent("PLAYER_REGEN_DISABLED", function(...)
        self:UpdateGUI()
    end)

    self:RegisterEvent("PLAYER_REGEN_ENABLED", function(...)
        self:UpdateGUI()
    end)

    self:RegisterEvent("PLAYER_UPDATE_RESTING", function(...)
        self:UpdateGUI()
    end)
end

function addon:ParseArgs(message)
    local arg, pos = self:GetArgs(message, 1, 1)

    if arg then
        if pos <= #message then
            return arg, message:sub(pos)
        else
            return arg
        end
    end
end

function addon:OnChatCommand(message)
    local cmd, param = self:ParseArgs(message)

    if not cmd then return end

    if cmd == "list" or cmd == "ls" then
        local list = {}

        local profile
        for profile in table.s2k_values({ self:GetProfiles() }) do
            table.insert(list, string.format("|c%s%s|r",
                RAID_CLASS_COLORS[profile.class].colorStr, profile.name
            ))
        end

        if #list > 0 then
            self:Printf(L.msg_profile_list, strjoin(", ", unpack(list)))
        else
            self:Printf(L.msg_profile_list_empty)
        end

    elseif cmd == "save" or cmd == "sv" then
        if param then
            local profile = self:GetProfiles(param, true)

            if profile then
                self:UpdateProfile(profile)
            else
                self:SaveProfile(param)
            end
        end

    elseif cmd == "delete" or cmd == "del" or cmd == "remove" or cmd == "rm" then
        if param then
            local profile = self:GetProfiles(param, true)

            if profile then
                self:DeleteProfile(profile.name)
            else
                self:Printf(L.msg_profile_not_exists, param)
            end
        end

    elseif cmd == "use" or cmd == "load" or cmd == "ld" then
        if param then
            local profile = self:GetProfiles(param, true)

            if profile then
                self:UseProfile(profile)
            else
                self:Printf(L.msg_profile_not_exists, param)
            end
        end
    end
end

function addon:ShowTooltip(anchor)
    if not (InCombatLockdown() or (self.tooltip and self.tooltip:IsShown())) then
        if not (qtip:IsAcquired(addonName) and self.tooltip) then
            self.tooltip = qtip:Acquire(addonName, 2, "LEFT")

            self.tooltip.OnRelease = function()
                self.tooltip = nil
            end
        end

        if anchor then
            self.tooltip:SmartAnchorTo(anchor)
            self.tooltip:SetAutoHideDelay(0.05, anchor)
        end

        self:UpdateTooltip(self.tooltip)
    end
end

function addon:UpdateTooltip(tooltip)
    tooltip:Clear()

    local line = tooltip:AddHeader(ABP_ADDON_NAME)

    local profiles = { addon:GetProfiles() }

    if #profiles > 0 then
        local class = select(2, UnitClass("player"))
        local cache = addon:MakeCache()

        line = tooltip:AddLine(L.tooltip_list)
        tooltip:SetCellTextColor(line, 1, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)

        local profile
        for profile in table.s2k_values(profiles) do
            local line

            local name = profile.name
            local color = NORMAL_FONT_COLOR

            if profile.class ~= class then
                color = GRAY_FONT_COLOR
            else
                local fail, total = addon:UseProfile(profile, true, cache)
                if fail > 0 then
                    color = RED_FONT_COLOR
                    name = name .. string.format(" (%d/%d)", fail, total)
                end
            end

            if profile.icon then
                line = tooltip:AddLine(string.format(
                    "  |T%s:14:14:0:0:32:32:0:32:0:32|t %s",
                    profile.icon, name
                ))
            else
                local coords = CLASS_ICON_TCOORDS[profile.class]
                line = tooltip:AddLine(string.format(
                    "  |TInterface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes:14:14:0:0:256:256:%d:%d:%d:%d|t %s",
                    coords[1] * 256, coords[2] * 256, coords[3] * 256, coords[4] * 256,
                    name
                ))
            end

            tooltip:SetCellTextColor(line, 1, color.r, color.g, color.b)

            tooltip:SetLineScript(line, "OnMouseUp", function()
                local fail, total = addon:UseProfile(profile, true, cache)

                if fail > 0 then
                    if not self:ShowPopup("CONFIRM_USE_ACTION_BAR_PROFILE", fail, total, { name = profile.name }) then
                        UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0)
                    end
                else
                    addon:UseProfile(profile, false, cache)
                end
            end)
        end
    else
        line = tooltip:AddLine(L.tooltip_list_empty)
        tooltip:SetCellTextColor(line, 1, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
    end

    tooltip:AddLine("")

    tooltip:UpdateScrolling()
    tooltip:Show()
end

function addon:UpdateGUI()
    if self.updateTimer then
        self:CancelTimer(self.updateTimer)
    end

    self.updateTimer = self:ScheduleTimer(function()
        self.updateTimer = nil

        if self.tooltip and self.tooltip:IsShown() then
            if InCombatLockdown() then
                self.tooltip:Hide()
            else
                self:UpdateTooltip(self.tooltip)
            end
        end
    end, 0.1)
end

function addon:EncodeLink(data)
    return data:gsub(".", function(x)
        return ((x:byte() < 32 or x:byte() == 127 or x == "|" or x == ":" or x == "[" or x == "]" or x == "~") and string.format("~%02x", x:byte())) or x
    end)
end

function addon:DecodeLink(data)
    return data:gsub("~[0-9A-Fa-f][0-9A-Fa-f]", function(x)
        return string.char(tonumber(x:sub(2), 16))
    end)
end

function addon:PackMacro(macro)
    return macro:gsub("^%s+", ""):gsub("%s+\n", "\n"):gsub("\n%s+", "\n"):gsub("%s+$", ""):sub(1)
end
