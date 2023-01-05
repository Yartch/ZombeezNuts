--- ======================================================
--- Sets up the general events and commands for the server.
--- ======================================================

local Commands = ZombeezNuts.Server.Commands

local onClientCommand = function(module, command, player, args)
    -- Ignore anything that isn't Nuts
    if module ~= "YartchZombieJesus" then
        return
    end

    if Commands[command] == nil then
        print("Invalid client command: " .. tostring(command))
        return
    end

    Commands[command](player, args)
end

Events.OnClientCommand.Add(onClientCommand);