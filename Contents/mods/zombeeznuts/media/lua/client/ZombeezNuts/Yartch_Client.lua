--- ======================================================
--- Sets up the general events and commands for the client.
--- ======================================================

local Commands = ZombeezNuts.Client.Commands

local function onServerCommand (module, command, args)
    -- Ignore anything that isn't Deez
    if module ~= "YartchZombieJesus" then
        return
    end

    if Commands[command] == nil then
        print("Invalid server command: " .. tostring(command))
        return
    end

    Commands[command](args)
end

Events.OnServerCommand.Add(onServerCommand); 