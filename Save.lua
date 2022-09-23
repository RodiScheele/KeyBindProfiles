local addonName, addon = ...

function addon:SaveProfile()
    local profile = self.db.profile.list

    profile.class = select(2, UnitClass("player"))

    profileName = self.db:GetCurrentProfile()

    if profileName ~= "Default" then
        self:SaveBindings(profile)
    end

end


function addon:SaveBindings(profile)
    local bindings = {}

    local index
    for index = 1, GetNumBindings() do
        local bind = { GetBinding(index) }
        if bind[3] then
            bindings[bind[1]] = { select(3, unpack(bind)) }
        end
    end

    profile.bindings = bindings

    local bindingsDominos = nil

    if LibStub("AceAddon-3.0"):GetAddon("Dominos", true) then
        bindingsDominos = {}

        for index = 13, 60 do
            local bind = { GetBindingKey(string.format("CLICK DominosActionButton%d:LeftButton", index)) }
            if #bind > 0 then
                bindingsDominos[index] = bind
            end
        end
    end

    profile.bindingsDominos = bindingsDominos
end