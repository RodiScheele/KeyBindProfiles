local addonName, addon = ...

LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0")

function addon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New(addonName .. "DBv1", {
        profile = {
            list = {}        },
    }, ({ UnitClass("player") })[2])

    self:RegisterChatCommand("kbp", "OnChatCommand")

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
    elseif cmd == "help" then
        self:ShowHelp()

    elseif cmd == "use" or cmd == "load" or cmd == "ld" then
        if param then
            local profile = self:GetProfiles(param, true)

            if profile then
                self:UseProfile(profile)
            else
                self:Printf("No profiles available", param)
            end
        end
    else
        self:Printf("Command not found, try '/kbp help' for more info")
    end
end

function addon:ShowHelp()
    local commands = {
        "KeyBindProfiles Commands:",
        " /kbp save <profilename>  -- Save or update the current keybinds",
        " /kbp load <profilename>  -- Loads an existing keybind profile",
        " /kbp delete <profilename> update  -- Deletes an existing keybind profile",
        " /kbp list -- Lists all existing profiles"
    }
    for index, line in ipairs(commands) do
        DEFAULT_CHAT_FRAME:AddMessage(line, 1, 1, 0)
    end
  end