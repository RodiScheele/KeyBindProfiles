local addonName, addon = ...

function addon:RestoreDbBindings()
    local profile = self.db.profile

    self.db.global.update_bindings_trigger = false

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

    if LibStub("AceAddon-3.0"):GetAddon("Dominos", true) and profile.bindingsDominos then
        for index = 1, 60 do
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
    end

    self.db.global.update_bindings_trigger = true
end

function addon:RestoreDefaultBindings()
    self.db.global.update_bindings_trigger = false
    self.db.profile.bindings = {}
    self.db.profile.bindingsDominos = {}
    LoadBindings(0)
    self:SaveBindings()
    self.db.global.update_bindings_trigger = true
    self:Print("Succesfully reset '" .. self.db:GetCurrentProfile() .. "' to default keybinds")
end