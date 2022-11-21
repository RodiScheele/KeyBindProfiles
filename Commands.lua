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

    if not cmd then return end

    if cmd == "list" then
        for k, v in pairs(self.db.profiles) do
            self:Print(k)
        end

    elseif cmd == "save" then
        local profile_name = self.db:GetCurrentProfile()
        self:Print("Saved to profile " .. profile_name)
        self:SaveProfile()

    elseif cmd == "delete" then
        if param then
            local exists = self:ProfileExists(param)
            if exists then
                self.db:DeleteProfile(param)
            end
        end

    elseif cmd == "load" then
        if param then
            local exists = self:ProfileExists(param)
            if exists then
                self.db:SetProfile(param)
                self.db:SetDualSpecProfile(param)
                self:Printf("Loaded " .. param)
            end
        end
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