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

    if cmd == "save" or cmd == "sv" then
        self:SaveProfile(param)

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
        " /kbp load <profilename>  -- Loads an existing keybind profile"
    }
    for index, line in ipairs(commands) do
        DEFAULT_CHAT_FRAME:AddMessage(line, 1, 1, 0)
    end
  end