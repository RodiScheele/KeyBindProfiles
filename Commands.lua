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
            
            self.db:DeleteProfile(param)

        end

    elseif cmd == "use" or cmd == "load" or cmd == "ld" then
        --[[if param then
            local profile = self:GetProfiles(param, true)

            if profile then
                self:UseProfile(profile)
            else
                self:Printf(L.msg_profile_not_exists, param)
            end
        end]]
    end
end