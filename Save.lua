local addonName, addon = ...

function addon:SaveProfile()
    if self.db.global.update_bindings_trigger then
        self:SaveBindings()
    end
end

function addon:SaveBindings()
    local bindings = {}

    local index
    for index = 1, GetNumBindings() do
        local bind = { GetBinding(index) }
        if bind[3] then
            bindings[bind[1]] = { select(3, unpack(bind)) }
        end
    end

    self.db.profile.bindings = bindings

    local bindingsDominos = nil

    if LibStub("AceAddon-3.0"):GetAddon("Dominos", true) then
        bindingsDominos = {}

        for index = 1, 60 do
            local bind = { GetBindingKey(string.format("CLICK DominosActionButton%d:LeftButton", index)) }
            if #bind > 0 then
                bindingsDominos[index] = bind
            end
        end
    end

    self.db.profile.bindingsDominos = bindingsDominos
end

function addon:InitializeProfile()
    local profile = self.db.profile
    if profile.bindings == nil then
        addon:SaveBindings()
    end
end