local addonName, addon = ...

LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0", "AceTimer-3.0", "AceEvent-3.0", "AceSerializer-3.0")

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

    -- chat command
    self:RegisterChatCommand("kbp", "OnChatCommand")

    -- settings page
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptions())

    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, nil, nil, "profiles")
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
            self:Printf("Available profiles: %s", strjoin(", ", unpack(list)))
        else
            self:Printf("No profiles available")
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
                self:Printf("No profiles available", param)
            end
        end

    elseif cmd == "use" or cmd == "load" or cmd == "ld" then
        if param then
            local profile = self:GetProfiles(param, true)

            if profile then
                self:UseProfile(profile)
            else
                self:Printf("No profiles available", param)
            end
        end
    end
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
