local addonName, addon = ...

function addon:GuessName(name)
    local list = self.db.profile.list

    if not list[name] then
        return name
    end

    local i
    for i = 2, 99 do
        local try = string.format("%s (%d)", name, i)
        if not list[try] then
            return try
        end
    end
end

function addon:SaveProfile(name, options)
    local list = self.db.profile.list
    local profile = { name = name }

    self:UpdateProfileOptions(profile, options, true)
    self:UpdateProfile(profile, true)

    list[name] = profile

    self:Printf("Profile %s saved", name)
end

function addon:UpdateProfileOptions(profile, options, quiet)
    if type(profile) ~= "table" then
        local list = self.db.profile.list
        profile = list[profile]

        if not profile then return end
    end

    if options then
        local k, v
        for k in pairs(profile) do
            if k:sub(1, 4) == "skip" then
                profile[k] = nil
            end
        end

        for k, v in pairs(options) do
            profile[k] = v
        end
    end
    if not quiet then
        self:Printf("Profile %s updated", profile.name)
    end
end

function addon:UpdateProfile(profile, quiet)
    if type(profile) ~= "table" then
        local list = self.db.profile.list
        profile = list[profile]

        if not profile then return end
    end

    profile.class = select(2, UnitClass("player"))

    self:SaveBindings(profile)

    if not quiet then
        self:Printf("Profile %s updated", profile.name)
    end

    return profile
end

function addon:RenameProfile(name, rename, quiet)
    local list = self.db.profile.list
    local profile = list[name]

    if not profile then return end

    profile.name = rename

    list[name] = nil
    list[rename] = profile

    self:Printf("Profile %s renamed to %s", name, rename)
end

function addon:DeleteProfile(name)
    local list = self.db.profile.list

    list[name] = nil

    self:Printf("Profile %s deleted", name)
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