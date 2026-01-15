local addonName, addon = ...


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

    if not cmd then
        Settings.OpenToCategory(optionsId)
        return
    end

        
    if cmd == "list" then
        self:Print("=========Profiles=========")
        for k, v in pairs(self.db.profiles) do
            self:Print(k)
        end
        self:Print("==========================")
        return
    elseif cmd == "save" then
        if param then
            local exists = self:ProfileExists(param)
            self.db:SetProfile(param)
            self:SaveProfile()
            self.db:SetDualSpecProfile(param)
            if not exists then
                self:Print("Created new profile " .. param)
            else
                self:Print("Saved to profile " .. param)
            end
        else
            local profile_name = self.db:GetCurrentProfile()
            self:SaveProfile()
            self:Print("Saved to current profile " .. profile_name)
        end
        return
    elseif cmd == "delete" then
        if param then
            if (self.db:GetCurrentProfile() == param) then
                self:Print("Can't delete the active profile")
                return
            end
            local exists = self:ProfileExists(param)
            if exists then
                self.db:DeleteProfile(param)
                self:Print(param .. " was deleted")
            else
                self:Print("Profile '" .. param .. "'' doesn't exist, nothing was deleted. (Hint: Profiles are case sensitive)")
            end
        else
            self:Print("No parameter given, try /kbp delete <profilename>")
        end
        return
    elseif cmd == "load" then
        if param then
            local exists = self:ProfileExists(param)
            if exists then
                self.db:SetProfile(param)
                self.db:SetDualSpecProfile(param)
                self:Print("Loaded profile " .. param)
            else
                self:Print("Could not find profile '" .. param .."'. (Hint: Profiles are case sensitive)")
            end
        else
            self:Print("No parameter given, try /kbp load <profilename>")
        end
        return
    elseif cmd == "help" then
        self:ShowHelp()
        return
    else
        self:Print("Command was not found, type '/kbp help' for a list of commands.")
        return
    end
end

function addon:ProfileExists(param)
    local profiles, i = self.db:GetProfiles()

    for i, v in pairs(profiles) do
        if (param == v) then
            return true
        end
    end

    return false
end

function addon:ShowHelp()
    local commands = {
        "KeyBindProfiles Commands:",
        " /kbp save -- Saves the current profile",
        " /kbp save <profilename>  -- Save to the specified profile. Overwrites existing profiles or creates a new profile if specified profile doesn't exist",
        " /kbp load <profilename>  -- Loads an existing profile",
        " /kbp delete <profilename>  -- Deletes an existing profile",
        " /kbp list -- Lists all existing profiles"
    }
    for index, line in ipairs(commands) do
        DEFAULT_CHAT_FRAME:AddMessage(line, 1, 1, 0)
    end
  end