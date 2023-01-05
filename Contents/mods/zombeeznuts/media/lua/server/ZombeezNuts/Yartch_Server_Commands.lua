--- ======================================================
--- Handlers for commands coming from clients.
--- ======================================================

local Commands = ZombeezNuts.Server.Commands
local Prayers = ZombeezNuts.Prayers

-- Player is attempting to do a prayer
function Commands.DoPrayer (player, args)
    local prayerName = args.prayerName

    -- Get a roll result from the prayer
    local result = Prayers:doPrayerRoll(player, prayerName)


    sendServerCommand("YartchZombieJesus", "PrayerResult", {
        playerId = player:getOnlineID(),
        success = (result ~= nil),
        prayerName = prayerName,
        resultName = result.resultIndex,
    })

    result.action(player)
end

-- Temporary function for testing spinning curse
function Commands.DebugSpinOn (player, args)
    sendServerCommand("YartchZombieJesus", "SpinCurse", {
        playerId = player:getOnlineID(),
        curseEnabled = true,
    })
end

-- Temporary function for testing spinning curse
function Commands.DebugSpinOff (player, args)
    sendServerCommand("YartchZombieJesus", "SpinCurse", {
        playerId = player:getOnlineID(),
        curseEnabled = false,
    })
end