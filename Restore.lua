local addonName, addon = ...

function addon:RestoreDbBindings()
    local profile = self.db.profile.list
    print("Profile name")
    profileName = self.db:GetCurrentProfile()
    print(profileName)

    if profileName == "Default" then
        self:RestoreDefaultBindings()
        self:SaveProfile()
        return
    end

    if LibStub("AceAddon-3.0"):GetAddon("Dominos", true) and profile.bindingsDominos then
        for index = 13, 60 do
            local key

            -- clear
            for key in table.s2k_values({ GetBindingKey(string.format("CLICK DominosActionButton%d:LeftButton", index)) }) do
                SetBinding(key)
            end

            -- restore
            if profile.bindingsDominos[index] then
                for key in table.s2k_values(profile.bindingsDominos[index]) do
                    SetBindingClick(key, string.format("DominosActionButton%d", index), "LeftButton")
                end
            end
        end
    else
        -- clear
        local index
        for index = 1, GetNumBindings() do
            local bind = { GetBinding(index) }
            if bind[3] then
                local key
                for key in table.s2k_values({ select(3, unpack(bind)) }) do
                    SetBinding(key)
                end
            end
        end

        -- restore
        local cmd, keys
        for cmd, keys in pairs(profile.bindings) do
            local key
            for key in table.s2k_values(keys) do
                SetBinding(key, cmd)
            end
        end
    end
end

function addon:RestoreDefaultBindings()
    LoadBindings(0)
end